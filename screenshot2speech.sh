#!/bin/bash
screencapture -s ~/Downloads/screen.png; tesseract ~/Downloads/screen.png ~/Downloads/screen; say -i -v $2 -r $2 -f ~/Downloads/screen.txt
