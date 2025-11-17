@echo off
REM Clinic Visit Tracker Launcher for Windows
title Clinic Visit Tracker

cd /d "%~dp0"

echo ========================================
echo   Clinic Visit Tracker
echo ========================================
echo.

REM Check if virtual environment exists
if not exist "venv\" (
    echo Setting up virtual environment...
    python -m venv venv
    if errorlevel 1 (
        echo Failed to create virtual environment.
        echo Please ensure Python is installed and in your PATH.
        pause
        exit /b 1
    )
)

REM Activate virtual environment
echo Activating virtual environment...
call venv\Scripts\activate.bat

REM Install/update requirements
if not exist ".requirements_installed" (
    echo Installing dependencies...
    pip install -r requirements.txt
    if not errorlevel 1 (
        type nul > .requirements_installed
    )
)

REM Start Flask server
echo Starting Clinic Visit Tracker...
start /B python app.py

REM Wait for server to start
timeout /t 3 /nobreak >nul

REM Open browser
echo Opening browser...
start http://127.0.0.1:5000

echo.
echo ========================================
echo Clinic Visit Tracker is running!
echo Access it at: http://127.0.0.1:5000
echo ========================================
echo.
echo Press any key to stop the server...
pause >nul

REM Kill Python process when user presses a key
taskkill /F /IM python.exe /FI "WINDOWTITLE eq Clinic Visit Tracker*" >nul 2>&1
echo Server stopped.
