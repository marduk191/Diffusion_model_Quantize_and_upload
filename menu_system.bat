@echo off
title Model Quantization and Upload Tool
color 0A

rem #user parameters (set defaults)
set fname=chroma-unlocked-v1
set basepath=%~dp0
set author=marduk191
set reponame=marduk191/Chroma_quants
set venv_path=I:\AI\ComfyUI\venv\Scripts\activate

:MAIN_MENU
cls
echo ==========================================
echo    MODEL QUANTIZATION AND UPLOAD TOOL
echo ==========================================
echo.
echo Current Settings:
echo   File Name: %fname%
echo   Author: %author%
echo   Repository: %reponame%
echo   Base Path: %basepath%
echo   Virtual Environment: %venv_path%
echo.
echo ==========================================
echo MAIN MENU
echo ==========================================
echo 1. Configure Settings
echo 2. Quantize Single Format
echo 3. Quantize Multiple Formats
echo 4. Quantize All Formats
echo 5. View File Info
echo 6. Exit
echo.
set /p choice="Select an option (1-6): "

if "%choice%"=="1" goto CONFIG_MENU
if "%choice%"=="2" goto SINGLE_QUANT_MENU
if "%choice%"=="3" goto MULTI_QUANT_MENU
if "%choice%"=="4" goto QUANTIZE_ALL
if "%choice%"=="5" goto FILE_INFO
if "%choice%"=="6" goto EXIT
echo Invalid choice. Please try again.
pause
goto MAIN_MENU

:CONFIG_MENU
cls
echo ==========================================
echo CONFIGURATION MENU
echo ==========================================
echo 1. Change File Name (Current: %fname%)
echo 2. Change Author (Current: %author%)
echo 3. Change Repository (Current: %reponame%)
echo 4. Change Base Path (Current: %basepath%)
echo 5. Change Virtual Environment Path (Current: %venv_path%)
echo 6. Return to Main Menu
echo.
set /p config_choice="Select an option (1-6): "

if "%config_choice%"=="1" (
    set /p fname="Enter new file name (without extension): "
    goto CONFIG_MENU
)
if "%config_choice%"=="2" (
    set /p author="Enter new author name: "
    goto CONFIG_MENU
)
if "%config_choice%"=="3" (
    set /p reponame="Enter new repository name: "
    goto CONFIG_MENU
)
if "%config_choice%"=="4" (
    set /p basepath="Enter new base path: "
    goto CONFIG_MENU
)
if "%config_choice%"=="5" (
    set /p venv_path="Enter new virtual environment path: "
    goto CONFIG_MENU
)
if "%config_choice%"=="6" goto MAIN_MENU
echo Invalid choice. Please try again.
pause
goto CONFIG_MENU

:SINGLE_QUANT_MENU
cls
echo ==========================================
echo SINGLE QUANTIZATION MENU
echo ==========================================
echo Select quantization format:
echo.
echo 1. F32 (32-bit float)
echo 2. F16 (16-bit float)
echo 3. BF16 (Base conversion)
echo 4. Q8_0 (8-bit quantization)
echo 5. Q6_K (6-bit K-quantization)
echo 6. Q5_K (5-bit K-quantization)
echo 7. Q5_K_M (5-bit K-quantization Medium)
echo 8. Q5_K_S (5-bit K-quantization Small)
echo 9. Q5_0 (5-bit quantization)
echo 10. Q5_1 (5-bit quantization v1)
echo 11. Q4_K (4-bit K-quantization)
echo 12. Q4_K_M (4-bit K-quantization Medium)
echo 13. Q4_K_S (4-bit K-quantization Small)
echo 14. Q4_0 (4-bit quantization)
echo 15. Q4_1 (4-bit quantization v1)
echo 16. Q3_K (3-bit K-quantization)
echo 17. Q3_K_L (3-bit K-quantization Large)
echo 18. Q3_K_M (3-bit K-quantization Medium)
echo 19. Q3_K_S (3-bit K-quantization Small)
echo 20. Q2_K (2-bit K-quantization)
echo 21. Q2_K_S (2-bit K-quantization Small)
echo 22. FP8 Scaled Stochastic
echo 23. Return to Main Menu
echo.
set /p quant_choice="Select quantization format (1-23): "

if "%quant_choice%"=="1" (
    set qversion=F32
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="2" (
    set qversion=F16
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="3" (
    set qversion=BF16
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="4" (
    set qversion=Q8_0
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="5" (
    set qversion=Q6_K
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="6" (
    set qversion=Q5_K
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="7" (
    set qversion=Q5_K_M
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="8" (
    set qversion=Q5_K_S
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="9" (
    set qversion=Q5_0
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="10" (
    set qversion=Q5_1
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="11" (
    set qversion=Q4_K
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="12" (
    set qversion=Q4_K_M
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="13" (
    set qversion=Q4_K_S
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="14" (
    set qversion=Q4_0
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="15" (
    set qversion=Q4_1
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="16" (
    set qversion=Q3_K
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="17" (
    set qversion=Q3_K_L
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="18" (
    set qversion=Q3_K_M
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="19" (
    set qversion=Q3_K_S
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="20" (
    set qversion=Q2_K
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="21" (
    set qversion=Q2_K_S
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="22" (
    set qversion=fp8_scaled_stochastic
    goto SINGLE_QUANTIZE
)
if "%quant_choice%"=="23" goto MAIN_MENU
echo Invalid choice. Please try again.
pause
goto SINGLE_QUANT_MENU

:MULTI_QUANT_MENU
cls
echo ==========================================
echo MULTIPLE QUANTIZATION MENU
echo ==========================================
echo Select formats to quantize (separate with spaces):
echo Example: 1 3 5 7
echo.
echo 1. F32 (32-bit float)
echo 2. F16 (16-bit float)
echo 3. BF16 (Base conversion)
echo 4. Q8_0 (8-bit quantization)
echo 5. Q6_K (6-bit K-quantization)
echo 6. Q5_K (5-bit K-quantization)
echo 7. Q5_K_M (5-bit K-quantization Medium)
echo 8. Q5_K_S (5-bit K-quantization Small)
echo 9. Q5_0 (5-bit quantization)
echo 10. Q5_1 (5-bit quantization v1)
echo 11. Q4_K (4-bit K-quantization)
echo 12. Q4_K_M (4-bit K-quantization Medium)
echo 13. Q4_K_S (4-bit K-quantization Small)
echo 14. Q4_0 (4-bit quantization)
echo 15. Q4_1 (4-bit quantization v1)
echo 16. Q3_K (3-bit K-quantization)
echo 17. Q3_K_L (3-bit K-quantization Large)
echo 18. Q3_K_M (3-bit K-quantization Medium)
echo 19. Q3_K_S (3-bit K-quantization Small)
echo 20. Q2_K (2-bit K-quantization)
echo 21. Q2_K_S (2-bit K-quantization Small)
echo 22. FP8 Scaled Stochastic
echo 23. Return to Main Menu
echo.
set /p multi_choice="Enter your choices: "

if "%multi_choice%"=="23" goto MAIN_MENU
goto PROCESS_MULTI_CHOICE

:PROCESS_MULTI_CHOICE
call :SETUP_ENVIRONMENT
for %%i in (%multi_choice%) do (
    if "%%i"=="1" call :QUANTIZE_FORMAT F32
    if "%%i"=="2" call :QUANTIZE_FORMAT F16
    if "%%i"=="3" call :QUANTIZE_FORMAT BF16
    if "%%i"=="4" call :QUANTIZE_FORMAT Q8_0
    if "%%i"=="5" call :QUANTIZE_FORMAT Q6_K
    if "%%i"=="6" call :QUANTIZE_FORMAT Q5_K
    if "%%i"=="7" call :QUANTIZE_FORMAT Q5_K_M
    if "%%i"=="8" call :QUANTIZE_FORMAT Q5_K_S
    if "%%i"=="9" call :QUANTIZE_FORMAT Q5_0
    if "%%i"=="10" call :QUANTIZE_FORMAT Q5_1
    if "%%i"=="11" call :QUANTIZE_FORMAT Q4_K
    if "%%i"=="12" call :QUANTIZE_FORMAT Q4_K_M
    if "%%i"=="13" call :QUANTIZE_FORMAT Q4_K_S
    if "%%i"=="14" call :QUANTIZE_FORMAT Q4_0
    if "%%i"=="15" call :QUANTIZE_FORMAT Q4_1
    if "%%i"=="16" call :QUANTIZE_FORMAT Q3_K
    if "%%i"=="17" call :QUANTIZE_FORMAT Q3_K_L
    if "%%i"=="18" call :QUANTIZE_FORMAT Q3_K_M
    if "%%i"=="19" call :QUANTIZE_FORMAT Q3_K_S
    if "%%i"=="20" call :QUANTIZE_FORMAT Q2_K
    if "%%i"=="21" call :QUANTIZE_FORMAT Q2_K_S
    if "%%i"=="22" call :QUANTIZE_FORMAT fp8_scaled_stochastic
)
echo.
echo Multi-quantization complete!
pause
goto MAIN_MENU

:SINGLE_QUANTIZE
call :SETUP_ENVIRONMENT
call :QUANTIZE_FORMAT %qversion%
echo.
echo Single quantization complete!
pause
goto MAIN_MENU

:QUANTIZE_ALL
echo Starting full quantization process...
call :SETUP_ENVIRONMENT
call :QUANTIZE_FORMAT F32
call :QUANTIZE_FORMAT F16
call :QUANTIZE_FORMAT BF16
call :QUANTIZE_FORMAT Q8_0
call :QUANTIZE_FORMAT Q6_K
call :QUANTIZE_FORMAT Q5_K
call :QUANTIZE_FORMAT Q5_K_M
call :QUANTIZE_FORMAT Q5_K_S
call :QUANTIZE_FORMAT Q5_0
call :QUANTIZE_FORMAT Q5_1
call :QUANTIZE_FORMAT Q4_K
call :QUANTIZE_FORMAT Q4_K_M
call :QUANTIZE_FORMAT Q4_K_S
call :QUANTIZE_FORMAT Q4_0
call :QUANTIZE_FORMAT Q4_1
call :QUANTIZE_FORMAT Q3_K
call :QUANTIZE_FORMAT Q3_K_L
call :QUANTIZE_FORMAT Q3_K_M
call :QUANTIZE_FORMAT Q3_K_S
call :QUANTIZE_FORMAT Q2_K
call :QUANTIZE_FORMAT Q2_K_S
call :QUANTIZE_FORMAT fp8_scaled_stochastic
echo.
echo All quantizations complete!
pause
goto MAIN_MENU

:SETUP_ENVIRONMENT
set input="%basepath%\in\%fname%.safetensors"
set output="%basepath%\out\%fname%\%fname%"
set mvers=BF16

rem #make directories
if not exist "%basepath%\out\%fname%" mkdir "%basepath%\out\%fname%"
timeout /t 1 /nobreak >nul

rem #activate venv
call %venv_path%
cd %basepath%\tools
goto :EOF

:QUANTIZE_FORMAT
set current_qversion=%1
echo.
echo ==========================================
echo Processing: %fname%-%current_qversion%-%author%
echo ==========================================

if "%current_qversion%"=="BF16" (
    echo Converting to BF16...
    python convert.py --src %input% --dst "%output%-%current_qversion%-%author%.gguf"
    timeout /t 5 /nobreak >nul
    goto UPLOAD_FILE
)

if "%current_qversion%"=="fp8_scaled_stochastic" (
    echo Quantizing to FP8 Scaled Stochastic...
    python convert_fp8_scaled_stochastic.py --input %input% --output "%output%-%current_qversion%-%author%.safetensors"
    timeout /t 5 /nobreak >nul
    echo Uploading %fname%-%current_qversion%-%author%.safetensors
    huggingface-cli upload %reponame% "%output%-%current_qversion%-%author%.safetensors" ./%fname%/"%fname%-%current_qversion%-%author%.safetensors" --commit-message "uploaded %fname%-%current_qversion%-%author%.safetensors"
    goto :EOF
)

rem Standard GGUF quantization
echo Quantizing to %current_qversion%...
llama-quantize.exe "%output%-%mvers%-%author%.gguf" "%output%-%current_qversion%-%author%.gguf" %current_qversion%
if "%current_qversion%"=="Q2_K" (
    timeout /t 3 /nobreak >nul
) else if "%current_qversion%"=="Q2_K_S" (
    timeout /t 3 /nobreak >nul
) else (
    timeout /t 1 /nobreak >nul
)

:UPLOAD_FILE
echo Uploading %fname%-%current_qversion%-%author%.gguf
huggingface-cli upload %reponame% "%output%-%current_qversion%-%author%.gguf" ./%fname%/"%fname%-%current_qversion%-%author%.gguf" --commit-message "uploaded %fname%-%current_qversion%-%author%.gguf"
goto :EOF

:FILE_INFO
cls
echo ==========================================
echo FILE INFORMATION
echo ==========================================
echo Input File: %basepath%\in\%fname%.safetensors
echo Output Directory: %basepath%\out\%fname%\
echo.
if exist "%basepath%\in\%fname%.safetensors" (
    echo   Input file exists
    for %%A in ("%basepath%\in\%fname%.safetensors") do echo   Size: %%~zA bytes
    for %%A in ("%basepath%\in\%fname%.safetensors") do echo   Modified: %%~tA
) else (
    echo   Input file does not exist!
)
echo.
if exist "%basepath%\out\%fname%" (
    echo  Output directory exists
    echo   Contents:
    dir "%basepath%\out\%fname%" /b 2>nul
) else (
    echo   Output directory does not exist
)
echo.
pause
goto MAIN_MENU

:EXIT
echo.
echo Thank you for using the Diffusion Model Quantization Tool!
echo Created by: marduk191
timeout /t 2 /nobreak >nul
exit