#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
SOURCE_DIR="${SCRIPT_DIR}/../ublue-os-packages/packages/bluefin/wallpapers"
OUTPUT_DIR="${SCRIPT_DIR}/../raw/jpeg"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Loop through all JXL files in the source directory
for file in "$SOURCE_DIR"/*.jxl; do
    # Check if there are any JXL files
    [ -e "$file" ] || { echo "No .jxl files found in $SOURCE_DIR"; exit 1; }

    # Get the base filename without the extension
    base_name=$(basename "$file" .jxl)

    # Define the output file path
    output_file="${OUTPUT_DIR}/${base_name}.jpeg"

    # Convert the file using ImageMagick
    magick "$file" "$output_file"

    echo "Converted: $file to $output_file"
done

echo "All conversions completed."
