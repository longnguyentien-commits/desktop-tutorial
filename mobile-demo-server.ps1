param(
  [string]$Root = $PSScriptRoot,
  [int]$Port = 4173
)

$ErrorActionPreference = 'Stop'
$rootPath = [System.IO.Path]::GetFullPath($Root).TrimEnd([System.IO.Path]::DirectorySeparatorChar)
$rootPrefix = $rootPath + [System.IO.Path]::DirectorySeparatorChar
$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add("http://127.0.0.1:$Port/")
$listener.Start()

Write-Output "Serving $rootPath at http://127.0.0.1:$Port/"

$mimeTypes = @{
  '.html' = 'text/html; charset=utf-8'
  '.htm'  = 'text/html; charset=utf-8'
  '.css'  = 'text/css; charset=utf-8'
  '.js'   = 'application/javascript; charset=utf-8'
  '.json' = 'application/json; charset=utf-8'
  '.png'  = 'image/png'
  '.jpg'  = 'image/jpeg'
  '.jpeg' = 'image/jpeg'
  '.gif'  = 'image/gif'
  '.webp' = 'image/webp'
  '.svg'  = 'image/svg+xml'
  '.mp3'  = 'audio/mpeg'
  '.wav'  = 'audio/wav'
  '.ogg'  = 'audio/ogg'
  '.mp4'  = 'video/mp4'
  '.woff' = 'font/woff'
  '.woff2' = 'font/woff2'
}

try {
  while ($listener.IsListening) {
    $context = $listener.GetContext()

    try {
      $relativePath = [System.Uri]::UnescapeDataString($context.Request.Url.AbsolutePath.TrimStart('/'))
      if ([string]::IsNullOrWhiteSpace($relativePath)) {
        $relativePath = 'Mobile Demo.html'
      }

      $relativePath = $relativePath.Replace('/', [System.IO.Path]::DirectorySeparatorChar)
      $filePath = [System.IO.Path]::GetFullPath((Join-Path $rootPath $relativePath))

      if (-not $filePath.StartsWith($rootPrefix, [System.StringComparison]::OrdinalIgnoreCase) -or
          -not [System.IO.File]::Exists($filePath)) {
        $context.Response.StatusCode = 404
        $payload = [System.Text.Encoding]::UTF8.GetBytes('Not found')
        $context.Response.ContentLength64 = $payload.Length
        $context.Response.OutputStream.Write($payload, 0, $payload.Length)
        continue
      }

      $extension = [System.IO.Path]::GetExtension($filePath).ToLowerInvariant()
      $contentType = $mimeTypes[$extension]
      if (-not $contentType) { $contentType = 'application/octet-stream' }

      $file = [System.IO.File]::OpenRead($filePath)
      try {
        $context.Response.StatusCode = 200
        $context.Response.ContentType = $contentType
        $context.Response.ContentLength64 = $file.Length
        $context.Response.Headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
        if ($context.Request.HttpMethod -ne 'HEAD') {
          $file.CopyTo($context.Response.OutputStream)
        }
      } finally {
        $file.Dispose()
      }
    } catch {
      $context.Response.StatusCode = 500
    } finally {
      $context.Response.OutputStream.Close()
    }
  }
} finally {
  $listener.Stop()
  $listener.Close()
}
