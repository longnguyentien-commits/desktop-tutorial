param(
  [Parameter(Mandatory = $true)]
  [string]$Url,
  [string]$ChromePath = 'C:\Program Files\Google\Chrome\Application\chrome.exe',
  [int]$Port = 9333
)

$ErrorActionPreference = 'Stop'
$profile = Join-Path $env:TEMP ('dvm-smoke-' + [guid]::NewGuid().ToString('N'))
$chromeOut = Join-Path $env:TEMP 'dvm-smoke-chrome-out.log'
$chromeError = Join-Path $env:TEMP 'dvm-smoke-chrome-error.log'
$results = [System.Collections.Generic.List[object]]::new()
$socket = $null
$chrome = $null
$script:cdpId = 0

function Add-Result([string]$Name, [bool]$Passed, [string]$Detail = '') {
  $results.Add([pscustomobject]@{ Test = $Name; Passed = $Passed; Detail = $Detail })
}

function Receive-CdpMessage {
  $buffer = New-Object byte[] 65536
  $stream = [System.IO.MemoryStream]::new()
  try {
    do {
      $segment = [ArraySegment[byte]]::new($buffer)
      $received = $socket.ReceiveAsync($segment, [Threading.CancellationToken]::None).GetAwaiter().GetResult()
      if ($received.MessageType -eq [System.Net.WebSockets.WebSocketMessageType]::Close) {
        throw 'Chrome DevTools socket closed unexpectedly.'
      }
      $stream.Write($buffer, 0, $received.Count)
    } while (-not $received.EndOfMessage)
    return [Text.Encoding]::UTF8.GetString($stream.ToArray()) | ConvertFrom-Json
  } finally {
    $stream.Dispose()
  }
}

function Invoke-Cdp([string]$Method, [hashtable]$Params = @{}) {
  $script:cdpId++
  $id = $script:cdpId
  $payload = @{ id = $id; method = $Method; params = $Params } | ConvertTo-Json -Depth 12 -Compress
  $bytes = [Text.Encoding]::UTF8.GetBytes($payload)
  $socket.SendAsync(
    [ArraySegment[byte]]::new($bytes),
    [System.Net.WebSockets.WebSocketMessageType]::Text,
    $true,
    [Threading.CancellationToken]::None
  ).GetAwaiter().GetResult() | Out-Null

  while ($true) {
    $message = Receive-CdpMessage
    if ($message.id -eq $id) {
      if ($message.error) { throw ($message.error | ConvertTo-Json -Compress) }
      return $message.result
    }
  }
}

function Invoke-JavaScript([string]$Expression) {
  $result = Invoke-Cdp 'Runtime.evaluate' @{
    expression = $Expression
    awaitPromise = $true
    returnByValue = $true
    userGesture = $true
  }
  if ($result.exceptionDetails) {
    throw $result.exceptionDetails.text
  }
  return $result.result.value
}

try {
  Remove-Item -LiteralPath $chromeOut,$chromeError -Force -ErrorAction SilentlyContinue
  $chrome = Start-Process -FilePath $ChromePath -ArgumentList @(
    '--headless=new',
    '--disable-gpu',
    '--hide-scrollbars',
    '--touch-events=enabled',
    '--no-first-run',
    "--remote-debugging-port=$Port",
    "--user-data-dir=$profile",
    '--window-size=844,390',
    $Url
  ) -WindowStyle Hidden -PassThru -RedirectStandardOutput $chromeOut -RedirectStandardError $chromeError

  $target = $null
  for ($i = 0; $i -lt 40 -and -not $target; $i++) {
    Start-Sleep -Milliseconds 250
    try {
      $pages = Invoke-RestMethod -Uri "http://127.0.0.1:$Port/json/list" -TimeoutSec 2
      $target = $pages | Where-Object { $_.type -eq 'page' -and $_.url -notlike 'devtools://*' } | Select-Object -First 1
    } catch {}
  }
  if (-not $target) { throw 'Chrome DevTools target was not available.' }

  $socket = [System.Net.WebSockets.ClientWebSocket]::new()
  $socket.ConnectAsync([Uri]$target.webSocketDebuggerUrl, [Threading.CancellationToken]::None).GetAwaiter().GetResult()
  Invoke-Cdp 'Runtime.enable' | Out-Null
  Invoke-Cdp 'Page.enable' | Out-Null

  $loaded = $false
  for ($i = 0; $i -lt 40 -and -not $loaded; $i++) {
    Start-Sleep -Milliseconds 250
    $loaded = [bool](Invoke-JavaScript "document.readyState === 'complete' && document.getElementById('game')?.contentDocument?.readyState === 'complete'")
  }
  Add-Result 'Public page and game iframe load' $loaded $Url

  $initial = Invoke-JavaScript @'
(() => ({
  title: document.title,
  startVisible: !document.getElementById('startOverlay').hidden,
  rotateDisplay: getComputedStyle(document.getElementById('rotateOverlay')).display,
  canvasReady: Boolean(document.getElementById('game')?.contentDocument?.getElementById('game')),
  canvasWidth: document.getElementById('game')?.contentDocument?.getElementById('game')?.width || 0,
  canvasHeight: document.getElementById('game')?.contentDocument?.getElementById('game')?.height || 0
}))()
'@
  Add-Result 'Landscape launch UI' ($initial.startVisible -and $initial.rotateDisplay -eq 'none') "rotate=$($initial.rotateDisplay)"
  Add-Result 'Game canvas available' ($initial.canvasReady -and $initial.canvasWidth -eq 1280 -and $initial.canvasHeight -eq 720) "$($initial.canvasWidth)x$($initial.canvasHeight)"

  $pwa = Invoke-JavaScript @'
(async () => {
  const response = await fetch('./mobile-demo.webmanifest', { cache: 'no-store' });
  const manifest = await response.json();
  await new Promise(resolve => setTimeout(resolve, 700));
  const registration = 'serviceWorker' in navigator ? await navigator.serviceWorker.getRegistration() : null;
  return {
    status: response.status,
    display: manifest.display,
    orientation: manifest.orientation,
    serviceWorker: Boolean(registration)
  };
})()
'@
  Add-Result 'PWA manifest' ($pwa.status -eq 200 -and $pwa.display -eq 'fullscreen' -and $pwa.orientation -eq 'landscape') "display=$($pwa.display), orientation=$($pwa.orientation)"
  Add-Result 'Service worker registration' ([bool]$pwa.serviceWorker) "registered=$($pwa.serviceWorker)"

  Invoke-Cdp 'Emulation.setDeviceMetricsOverride' @{
    width = 390; height = 844; deviceScaleFactor = 2; mobile = $true
    screenOrientation = @{ type = 'portraitPrimary'; angle = 0 }
  } | Out-Null
  Start-Sleep -Milliseconds 400
  $portrait = Invoke-JavaScript @'
(() => {
  const overlay = document.getElementById('rotateOverlay');
  const panel = overlay.querySelector('.panel');
  const rect = panel.getBoundingClientRect();
  return {
    display: getComputedStyle(overlay).display,
    viewportWidth: window.innerWidth,
    left: rect.left,
    right: rect.right,
    width: rect.width
  };
})()
'@
  Add-Result 'Portrait rotation blocker' ($portrait.display -eq 'grid') "display=$($portrait.display)"
  Add-Result 'Portrait UI fits viewport' ($portrait.left -ge 0 -and $portrait.right -le ($portrait.viewportWidth + 1)) "viewport=$($portrait.viewportWidth), left=$($portrait.left), right=$($portrait.right), width=$($portrait.width)"

  Invoke-Cdp 'Emulation.setDeviceMetricsOverride' @{
    width = 844; height = 390; deviceScaleFactor = 2; mobile = $true
    screenOrientation = @{ type = 'landscapePrimary'; angle = 90 }
  } | Out-Null
  Start-Sleep -Milliseconds 400

  $button = Invoke-JavaScript @'
(() => {
  const rect = document.getElementById('startButton').getBoundingClientRect();
  return { x: rect.left + rect.width / 2, y: rect.top + rect.height / 2 };
})()
'@
  foreach ($type in @('mousePressed','mouseReleased')) {
    Invoke-Cdp 'Input.dispatchMouseEvent' @{
      type = $type; x = [double]$button.x; y = [double]$button.y
      button = 'left'; clickCount = 1
    } | Out-Null
  }
  Start-Sleep -Milliseconds 900
  $entered = Invoke-JavaScript @'
(() => ({
  overlayHidden: document.getElementById('startOverlay').hidden,
  fullscreen: Boolean(document.fullscreenElement || document.webkitFullscreenElement),
  fallbackVisible: !document.getElementById('fullscreenButton').hidden
}))()
'@
  Add-Result 'Enter Game interaction' ([bool]$entered.overlayHidden) "overlayHidden=$($entered.overlayHidden)"
  Add-Result 'Fullscreen or visible fallback' ($entered.fullscreen -or $entered.fallbackVisible) "fullscreen=$($entered.fullscreen), fallback=$($entered.fallbackVisible)"

  for ($i = 0; $i -lt 32; $i++) {
    $lobbyLoaded = [bool](Invoke-JavaScript "document.getElementById('game').contentDocument.getElementById('prototypeLoading').classList.contains('is-complete')")
    if ($lobbyLoaded) { break }
    Start-Sleep -Milliseconds 250
  }
  Add-Result 'Game lobby loading completes' $lobbyLoaded "complete=$lobbyLoaded"

  $eventsOpened = Invoke-JavaScript @'
(() => {
  const doc = document.getElementById('game').contentDocument;
  doc.getElementById('prototypeLobbyEventButton').click();
  return doc.getElementById('prototypeTycoon').classList.contains('is-events-open');
})()
'@
  Add-Result 'Open Events function' ([bool]$eventsOpened) "open=$eventsOpened"

  $panelOpened = Invoke-JavaScript @'
(() => {
  const doc = document.getElementById('game').contentDocument;
  doc.getElementById('prototypeEventTag').click();
  return doc.getElementById('prototypeEventPanel').classList.contains('is-open') &&
    doc.getElementById('prototypeEventPanel').getAttribute('aria-hidden') === 'false';
})()
'@
  Add-Result 'Open event panel function' ([bool]$panelOpened) "open=$panelOpened"

  Invoke-JavaScript "document.getElementById('game').contentDocument.getElementById('prototypeBattleButton').click(); true" | Out-Null
  Start-Sleep -Milliseconds 800
  $battle = Invoke-JavaScript @'
(() => {
  const doc = document.getElementById('game').contentDocument;
  const canvas = doc.getElementById('game');
  return {
    pregameHidden: doc.getElementById('prototypePregame').hidden,
    canvasVisible: canvas.getBoundingClientRect().width > 0 && canvas.getBoundingClientRect().height > 0,
    tutorialPresent: Boolean(doc.getElementById('tutorialOverlay'))
  };
})()
'@
  Add-Result 'Battle transition function' ($battle.pregameHidden -and $battle.canvasVisible -and $battle.tutorialPresent) "pregameHidden=$($battle.pregameHidden), canvasVisible=$($battle.canvasVisible)"

  $failed = @($results | Where-Object { -not $_.Passed })
  $results | Format-Table -AutoSize | Out-String | Write-Output
  Write-Output "SMOKE_TOTAL=$($results.Count)"
  Write-Output "SMOKE_FAILED=$($failed.Count)"
  if ($failed.Count -gt 0) { exit 1 }
} finally {
  if ($socket) { $socket.Dispose() }
  if ($chrome -and -not $chrome.HasExited) { Stop-Process -Id $chrome.Id -Force -ErrorAction SilentlyContinue }
  if ((Test-Path -LiteralPath $profile) -and ((Resolve-Path -LiteralPath $profile).Path.StartsWith((Resolve-Path -LiteralPath $env:TEMP).Path))) {
    Remove-Item -LiteralPath $profile -Recurse -Force -ErrorAction SilentlyContinue
  }
}
