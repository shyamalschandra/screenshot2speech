# ScreenShot2Speech for macOS
## Version 0.3 (for macOS 11.5.7 Big Sur)
### by Shyamal Suhana Chandra, shyamalc@gmail.com

-----------

**Purpose:** This bash script for MacOS is used to convert a selectable screenshot of the macOS desktop into speech synthesis inside a command line prompt with interactive speaking and highlighting of spoken words.

-----------


**Prequisites:** 

0. Install [pip](https://pip.pypa.io/en/stable/installation/).
1. Please install Homebrew with the following command: `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`.
2. Please do a `brew install tesseract`.
3. Please do a `brew install pkg-config poppler`.
4. Please do a `pip3 install numpy`
5. Run the following commands in this [comment](https://github.com/mozilla/TTS/issues/726#issuecomment-913570903).
6. Please do a `sudo pip install --user TTS`.
7. Please do a `brew install mplayer`.
8. Download the screenshot2speech: `git clone https://github.com/shyamalschandra/screenshot2speech`
9. Go to **System Preferences** -> **Security & Privacy** -> **Privacy** -> **Screen Recording** -> Add the **Terminal** with the checkbox on.

Also, do a `chmod +x screenshot2speech.sh` before running.

**Example command:**

`./screenshot2speech.sh`
