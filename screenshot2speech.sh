#!/bin/bash

# This script is now used as the original binary that will be encrypted
# The wrapper script in the formula will handle decryption and execution

# Define paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCREENSHOT_PATH="$HOME/Downloads/screen.png"
OUTPUT_TEXT_PATH="$HOME/Downloads/screen.txt"
AUDIO_OUTPUT_PATH="$HOME/Downloads/screen2speech.aiff"

# Function to clean up temporary files
cleanup() {
    # Remove screenshot and text files if they exist
    [ -f "$SCREENSHOT_PATH" ] && rm -f "$SCREENSHOT_PATH"
    [ -f "$OUTPUT_TEXT_PATH" ] && rm -f "$OUTPUT_TEXT_PATH"
    [ -f "$AUDIO_OUTPUT_PATH" ] && rm -f "$AUDIO_OUTPUT_PATH"
}

# Trap EXIT signal to ensure cleanup
trap cleanup EXIT

# Main script execution
echo "Capturing screen..."
screencapture -s "$SCREENSHOT_PATH"

if [ ! -f "$SCREENSHOT_PATH" ]; then
    echo "Failed to capture screen."
    exit 1
fi

echo "Extracting text from screenshot..."
tesseract "$SCREENSHOT_PATH" "$OUTPUT_TEXT_PATH" 2>/dev/null

if [ ! -f "$OUTPUT_TEXT_PATH.txt" ]; then
    echo "Failed to extract text from screenshot."
    exit 1
fi

# Use the extracted text file
OUTPUT_TEXT_PATH="$OUTPUT_TEXT_PATH.txt"

echo "Converting text to speech..."
say --progress -f "$OUTPUT_TEXT_PATH" -v "Zoe (Premium)" -o "$AUDIO_OUTPUT_PATH"

if [ ! -f "$AUDIO_OUTPUT_PATH" ]; then
    echo "Failed to generate audio."
    exit 1
fi

echo "Playing audio..."
mplayer "$AUDIO_OUTPUT_PATH"

# Cleanup is handled by the trap 
