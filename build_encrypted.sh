#!/bin/bash

# This script encrypts the screenshot2speech binary during Homebrew installation

set -e

if [ $# -ne 3 ]; then
    echo "Usage: $0 <original_binary> <install_dir> <name>"
    exit 1
fi

ORIGINAL_BINARY="$1"
INSTALL_DIR="$2"
NAME="$3"
ENCRYPTED_BIN="$INSTALL_DIR/${NAME}.enc"
KEY_FILE="$INSTALL_DIR/key.bin"

# Generate a random AES-256 key
echo "Generating AES-256 key..."
openssl rand -hex 32 > "$KEY_FILE"

# Encrypt the binary
if [ -f "$ORIGINAL_BINARY" ]; then
    echo "Encrypting $ORIGINAL_BINARY..."
    openssl enc -aes-256-cbc -salt -in "$ORIGINAL_BINARY" -out "$ENCRYPTED_BIN" -pass "file:$KEY_FILE" -pbkdf2
    
    # Verify encryption
    if [ $? -eq 0 ] && [ -f "$ENCRYPTED_BIN" ]; then
        echo "Successfully encrypted $ORIGINAL_BINARY to $ENCRYPTED_BIN"
        
        # Remove the original binary (it's now encrypted)
        rm -f "$ORIGINAL_BINARY"
    else
        echo "Failed to encrypt $ORIGINAL_BINARY"
        exit 1
    fi
else
    echo "Original binary not found: $ORIGINAL_BINARY"
    exit 1
fi

echo "Encryption process completed successfully."