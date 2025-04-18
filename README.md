# PNG to WebP Conversion Script Documentation

## Overview

This bash script automatically converts PNG images to the WebP format while preserving transparency and deletes the original PNG files after successful conversion. It's designed to run on Windows using Windows Subsystem for Linux (WSL).

## Features

- Batch conversion of PNG images to WebP format
- Configurable quality settings
- Automatic deletion of original files after successful conversion
- Progress tracking and reporting
- Space savings calculation

## Requirements

- Windows operating system
- Windows Subsystem for Linux (WSL) installed
- ImageMagick installed in WSL

## Installation

### Setting up WSL

1. Open PowerShell as Administrator
2. Install WSL:
   ```powershell
   wsl --install
   ```
3. Restart your computer
4. Complete the Linux setup when prompted

### Installing ImageMagick

1. Open WSL terminal
2. Update package lists:
   ```bash
   sudo apt update
   ```
3. Install ImageMagick:
   ```bash
   sudo apt install imagemagick
   ```

## Usage

### Preparing the Script

1. Save the script to a file named `png-to-webp.sh`
2. Make the script executable:
   ```bash
   chmod +x png-to-webp.sh
   ```
3. Edit the script to set your target directory:
   ```bash
   # Change this path to your target directory
   BASE_DIR="/mnt/c/Users/YourUsername/YourDirectory"
   ```

### Running the Script

Execute the script in WSL terminal:
```bash
./png-to-webp.sh
```

The script will:
1. Display a warning message
2. Give you 5 seconds to cancel (Ctrl+C) if needed
3. Count the total PNG files to be processed
4. Convert each PNG file to WebP format
5. Delete the original PNG files after successful conversion
6. Display progress updates
7. Show the final conversion statistics and space saved

## Script Configuration

You can customize the script by modifying these variables:

- `BASE_DIR`: The directory containing PNG images to convert
- `QUALITY`: WebP quality setting (0-100, higher values mean better quality but larger files)

## Path Conversion Reference

Windows paths need to be converted to WSL format:

| Windows Path | WSL Path |
|--------------|----------|
| C:\ | /mnt/c/ |
| D:\ | /mnt/d/ |

Example: `C:\Users\John\Pictures` becomes `/mnt/c/Users/John/Pictures`

## Example Output

```
Starting PNG to WebP conversion...
WARNING: Original PNG files will be deleted after conversion
Press Ctrl+C now to cancel if you need to backup files first
Converted and deleted: /mnt/c/Users/user/images/logo.png (1/25)
Converted and deleted: /mnt/c/Users/user/images/banner.png (2/25)
...
Conversion complete! Converted 25 out of 25 files.
Space saved: 15M remaining in directory.
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Permission denied | Make the script executable with `chmod +x png-to-webp.sh` |
| Command not found | Ensure ImageMagick is installed with `convert --version` |
| No files converted | Verify your BASE_DIR path is correct and contains PNG files |
| WSL not recognized | Make sure WSL is properly installed with `wsl --status` |

## Full Script Reference

```bash
#!/bin/bash
# Bash script to convert PNG images to WebP and delete originals
# Set the base directory with correct WSL path format
BASE_DIR="/mnt/c/Users/afaque/Desktop/Hydrasearch catalog/Website - Defense"
# Quality setting for WebP (0-100)
QUALITY=85
echo "Starting PNG to WebP conversion..."
echo "WARNING: Original PNG files will be deleted after conversion"
echo "Press Ctrl+C now to cancel if you need to backup files first"
sleep 5  # Give user 5 seconds to cancel if needed
# Counter for tracking progress
total_files=$(find "$BASE_DIR" -type f -name "*.png" | wc -l)
converted=0
# Find all PNG files, convert them, and delete originals
find "$BASE_DIR" -type f -name "*.png" | while read -r file; do
    # Get the output path (replace .png with .webp)
    output_path="${file%.png}.webp"
    
    # Convert PNG to WebP preserving transparency
    if convert "$file" -quality "$QUALITY" "$output_path"; then
        # Check if the WebP file was created successfully
        if [ -f "$output_path" ]; then
            # Delete the original PNG after successful conversion
            rm "$file"
            converted=$((converted+1))
            echo "Converted and deleted: $file ($converted/$total_files)"
        else
            echo "Conversion failed, original kept: $file"
        fi
    else
        echo "ERROR converting: $file"
    fi
done
echo "Conversion complete! Converted $converted out of $total_files files."
echo "Space saved: $(du -sh "$BASE_DIR" | awk '{print $1}') remaining in directory."
```

## Benefits of WebP Format

- 25-35% smaller file sizes compared to PNG at equivalent quality
- Faster website loading times
- Better SEO performance
- Support for transparency (like PNG)
- Broad browser support

## Safety Note

This script deletes original PNG files after conversion. It's recommended to create a backup of your images before running the script for the first time.
