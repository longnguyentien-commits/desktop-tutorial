@echo off
setlocal
cd /d "%~dp0"

set "PORT=8001"

for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /R /C:"IPv4 Address"') do (
  set "IP=%%A"
  goto :got_ip
)

:got_ip
set "IP=%IP: =%"

echo.
echo ==========================================
echo  Dragon vs Monsters LAN Server
echo ==========================================
echo.
echo Game folder:
echo %CD%
echo.
if defined IP (
  echo Share this link with computers on the same network:
  echo http://%IP%:%PORT%/Dragons%%20vs%%20Monsters.html
) else (
  echo Could not auto-detect IPv4 address.
  echo Run ipconfig and use: http://YOUR_IPV4:%PORT%/Dragons%%20vs%%20Monsters.html
)
echo.
echo Local test link:
echo http://127.0.0.1:%PORT%/Dragons%%20vs%%20Monsters.html
echo.
echo Keep this window open while people are playing.
echo Press Ctrl+C to stop the server.
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0lan-server.ps1" -Port %PORT% -Root "%~dp0"

pause
