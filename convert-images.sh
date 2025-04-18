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