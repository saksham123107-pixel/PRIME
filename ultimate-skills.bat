@echo off
rem ============================================================
rem  ULTIMATE SKILLS - Windows one-click launcher
rem  Double-click me, or run from CMD:
rem     ultimate-skills.bat
rem     ultimate-skills.bat --all-agents
rem     ultimate-skills.bat --all-agents --ponytail
rem ============================================================
setlocal
set "HERE=%~dp0"

where node >nul 2>nul
if %errorlevel%==0 (
  node "%HERE%bin\cli.js" %*
  goto :done
)

where powershell >nul 2>nul
if %errorlevel%==0 (
  powershell -NoProfile -ExecutionPolicy Bypass -File "%HERE%ultimate-skills.ps1" %*
  goto :done
)

echo [!] Neither Node.js nor PowerShell found.
echo     Install Node.js from https://nodejs.org then retry.
:done
echo.
pause
