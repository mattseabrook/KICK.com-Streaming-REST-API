@echo off

if "%1"=="chrome" (
  set EXE_NAME=chrome.exe
) else if "%1"=="brave" (
  set EXE_NAME=brave.exe
) else if "%1"=="edge" (
  set EXE_NAME=msedge.exe
) else (
  echo Invalid argument: %1
  exit /b
)

if "%2"=="" (
  set SEARCH_PATH=C:\
) else (
  set SEARCH_PATH=%2
)

for /f "tokens=*" %%a in ('where /r "%SEARCH_PATH%" "%EXE_NAME%" 2^>nul') do (
  set FULL_PATH=%%a
  goto DISPLAY
)
echo %1 executable file not found on the local hard drive
exit /b

:DISPLAY
echo Found %1 at %FULL_PATH%
exit /b
