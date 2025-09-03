@echo off
setlocal enabledelayedexpansion

:: Install UV if not installed
where /q uv
if %ERRORLEVEL% neq 0 (
    echo UV package manager not found. Installing UV...

    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"

    :: Add uv to the PATH for this session (use delayed expansion to avoid breaking the IF block)
    SET "PATH=!PATH!;%USERPROFILE%\.local\bin"
)

:: Get python script name from batchfile name and run from the script's directory
cd /d "%~dp0"
set SCRIPTNAME=%~n0.py
uv run "%SCRIPTNAME%"

pause
