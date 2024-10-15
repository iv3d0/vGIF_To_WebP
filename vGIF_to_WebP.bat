@echo off
setlocal enabledelayedexpansion

:: Set input and output directories (relative paths based on current directory)
set "input_folder=."
set "output_folder=output_webp"
set "ffmpeg_url=https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip"
set "ffmpeg_folder=ffmpeg"

:: Check if the ffmpeg folder exists and locate ffmpeg.exe dynamically
if exist "%ffmpeg_folder%" (
    for /D %%d in ("%ffmpeg_folder%\ffmpeg-*") do (
        set "ffmpeg_exe=%%d\bin\ffmpeg.exe"
        if exist "!ffmpeg_exe!" (
            echo ffmpeg found in "!ffmpeg_exe!".
            goto :ffmpeg_found
        )
    )
)

:ffmpeg_not_found
if not exist "!ffmpeg_exe!" (
    echo ffmpeg not found. Downloading and extracting ffmpeg...
    curl -L -o ffmpeg.zip "%ffmpeg_url%"
    
    echo Extracting ffmpeg...
    powershell -command "Expand-Archive -Path 'ffmpeg.zip' -DestinationPath '%cd%\ffmpeg'"
    
    del ffmpeg.zip
    
    :: After extraction, locate the newly extracted ffmpeg folder
    for /D %%d in ("%ffmpeg_folder%\ffmpeg-*") do (
        set "ffmpeg_exe=%%d\bin\ffmpeg.exe"
        if exist "!ffmpeg_exe!" (
            echo ffmpeg successfully downloaded and extracted in "!ffmpeg_exe!".
            goto :ffmpeg_found
        )
    )
    
    :: If ffmpeg.exe is still not found
    echo Error: ffmpeg not found after extraction. Please check the extraction process.
    pause
    exit /b 1
)

:ffmpeg_found
:: Check if there are any GIF files in the folder
echo Checking for GIF files in the current directory...
set "gif_found=false"
for %%f in (*.gif) do (
    set "gif_found=true"
    goto :found_gif
)

:found_gif
if "%gif_found%"=="false" (
    echo No GIF files found in the current directory. Please ensure there are GIF files to convert.
    pause
    exit /b 1
)

:: Prompt user for compression quality and loop settings
echo Choose compression quality (0-100, 100 = best quality):
set /p quality="Enter quality: "

echo Do you want the WebP to loop indefinitely? (y/n):
set /p loop_choice="Enter y or n: "
if /I "%loop_choice%"=="y" (
    set "loop=0"
) else (
    set "loop=-1"
)

:: Create the output directory if it doesn't exist
if not exist "%output_folder%" (
    echo Creating output folder "%output_folder%"...
    mkdir "%output_folder%"
)

:: Loop through all GIF files in the current folder and convert them
for %%f in (*.gif) do (
    set "filename=%%~nf"
    echo Converting: "%%f"
    "!ffmpeg_exe!" -i "%%f" -c:v libwebp -lossless 0 -q:v !quality! -loop !loop! -an -vsync 0 "%output_folder%\!filename!.webp"
    if errorlevel 1 (
        echo Error converting "%%f". Skipping this file.
    ) else (
        echo Successfully converted "%%f" to !filename!.webp
    )
)

echo All GIFs have been converted and saved in "%output_folder%".
pause
endlocal
