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





REM disable video & audio in the browser as well via command-line