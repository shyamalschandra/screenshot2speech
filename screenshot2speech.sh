#!/bin/bash
screencapture -s ~/Downloads/screen.png; tesseract ~/Downloads/screen.png ~/Downloads/screen; say --progress -f ~/Downloads/screen.txt -v "Zoe (Premium)" -o ~/Downloads/screen2speech.aiff; mplayer ~/Downloads/screen2speech.aiff 
