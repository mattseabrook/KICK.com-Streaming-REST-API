REM @echo off

REM    KICKstand v.0.1
REM    by @mattseabrook

REM    Github: https://github.com/mattseabrook/KICKstand

REM vars
set tempfolder=%temp%\KICKstand

REM Check if the temporary folder already exists
if not exist %tempfolder% mkdir %tempfolder%

REM Start the browser in headless mode
if "%2" == "chrome" (
  start "" chrome.exe --headless ^
  --remote-debugging-port=9222 ^
  --title="KICKstand" ^
  --user-data-dir="%tempfolder%" ^
  https://www.kick.com/%1
) else if "%2" == "brave" (
  start "" "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" --headless ^
  --remote-debugging-port=9222 ^
  --title="KICKstand" ^
  --user-data-dir="%tempfolder%" ^
  https://www.kick.com/%1
) else (
  echo Unknown browser specified
)

REM Wait for the headless browser to start and find the process ID using a loop
set PID=
set MAX_WAIT_TIME=30
set WAIT_INTERVAL=1
set /a WAIT_TIME=0
:LOOP
timeout /t %WAIT_INTERVAL% /nobreak > nul
set /a WAIT_TIME+=WAIT_INTERVAL
if %WAIT_TIME% geq %MAX_WAIT_TIME% (
  echo Timed out waiting for the headless browser to start
  exit /b
)
for /f "tokens=2" %%a in ('tasklist /v /fi "WINDOWTITLE eq KICKStand" /fo list ^| findstr /b "PID:"') do set PID=%%a
if not defined PID goto LOOP


echo The process ID of the browser is %PID%







REM disable video & audio in the browser as well via command-line