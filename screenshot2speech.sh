#!/bin/bash
screencapture -s ~/Downloads/screen.png; tesseract ~/Downloads/screen.png ~/Downloads/screen; tts --text "`cat ~/Downloads/screen.txt`" --out_path screen2speech.wav; mplayer screen2speech.wav 
