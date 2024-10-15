# GIF to WebP Converter Script

A simple batch script to convert GIF files to WebP format using `ffmpeg`. This script automatically downloads `ffmpeg` if not already present and converts all GIF files in the current directory to WebP format. The converted files are stored in a new folder named `output_webp`.

## Features

- **Automated `ffmpeg` Download**: The script downloads `ffmpeg` if it is not found in the current directory.
- **Batch Conversion**: Converts all GIF files in the current folder to WebP format.
- **Customizable Compression**: Allows you to set the quality of compression (0-100).
- **Loop Control**: Option to control whether the output WebP loops indefinitely.
- **Lightweight**: Uses `ffmpeg`, a powerful multimedia framework, to handle conversions.

## Prerequisites

Before using the script, make sure you have:

- **Windows OS**: The script is a Windows Batch script (`.bat`), so it requires a Windows environment to run.
- **curl**: The script uses `curl` to download `ffmpeg` if it's not present. Make sure `curl` is installed on your system or included in your environment.

## How to Use

1. **Clone the repository** or download the `.bat` script to your local machine.
   ```bash
   git clone https://github.com/iv3d0/vGIF_To_WebP.git
   cd your-repository
   Place the script in the same folder as the GIF files you want to convert.
   ```

Run the script by double-clicking it or running it in the command prompt.

Set compression quality and looping behavior when prompted:

Compression quality: Enter a value between 0 and 100 (higher means better quality but larger file size).
Loop: Enter y if you want the WebP to loop indefinitely, or n otherwise.
The converted files will be saved in an output_webp folder in the same directory.

Example Usage
- Place all your GIFs and the script in the same folder.
- Run the script.
- Enter the desired compression quality (e.g., 50 for medium quality).
- Choose whether the WebP should loop (y for yes, n for no).
- All converted WebP files will be saved in the output_webp folder.