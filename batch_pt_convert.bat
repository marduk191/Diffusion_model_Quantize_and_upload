call I:\AI\ComfyUI\venv\Scripts\activate
@echo off
setlocal enabledelayedexpansion

:: Set the input directory
set "input_dir=%~dp0in"

:: Check if input directory exists
if not exist "%input_dir%" (
    echo Input directory does not exist: %input_dir%
    mkdir %input_dir%
)

echo Scanning directory: %input_dir%

:: Loop through all files in the input directory
for %%f in ("%input_dir%\*") do (
    :: Check if extension is .pth
    if /i "%%~xf"==".pth, .pt" (
        echo Pickle file detected: %%~nxf
        echo Converting to safetensors format.
        call python %~dp0tools\pt_to_safe.py "%%f"
    ) else (
        echo File extension is %%~xf
        echo Skipping %%~nxf 
    )
)

echo Done converting files.