@echo off
setlocal

rem ===========================================================
rem  Bennett Barcode - Kiosk Printing Mode
rem
rem  Opens the GitHub Pages site with the print dialog disabled.
rem  The [print] button sends jobs straight to the DEFAULT
rem  printer, with no confirmation.
rem
rem  Set your label printer as the Windows default printer
rem  before using this.
rem
rem  To use the LOCAL file instead of the website, comment out
rem  the SITE line below and uncomment the two LOCAL lines.
rem ===========================================================

rem --- SITE (default) ---
set "TARGET=https://qogmlwo000.github.io/bennettbarcode/?kiosk=1"

rem --- LOCAL (offline) ---
rem set "APP=%~dp0index.html"
rem set "TARGET=file:///%APP:\=/%?kiosk=1"

set "BROWSER="
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" set "BROWSER=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if not defined BROWSER if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" set "BROWSER=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
if not defined BROWSER if exist "%LocalAppData%\Google\Chrome\Application\chrome.exe" set "BROWSER=%LocalAppData%\Google\Chrome\Application\chrome.exe"
if not defined BROWSER if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" set "BROWSER=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
if not defined BROWSER if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" set "BROWSER=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
if not defined BROWSER goto :nobrowser

rem A separate user-data-dir guarantees the kiosk-printing flag
rem applies even when another browser window is already open.
start "" "%BROWSER%" --kiosk-printing --user-data-dir="%LocalAppData%\BennettBarcodeKiosk" --no-first-run --no-default-browser-check "%TARGET%"
exit /b 0

:nobrowser
echo.
echo  ERROR: Chrome or Edge not found.
echo.
pause
exit /b 1
