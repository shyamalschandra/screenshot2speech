# ScreenShot2Speech for macOS
## Version 0.4 (for macOS 13.5.2 Ventura)
### by Shyamal Suhana Chandra, shyamalc@gmail.com

-----------

**Purpose:** This bash script for MacOS is used to convert a selectable screenshot of the macOS desktop into speech synthesis inside a command line prompt with batch processed speaking using mplayer.

-----------


**Prequisites:** 

0. Install [pip](https://pip.pypa.io/en/stable/installation/).
1. Please install Homebrew with the following command: `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`.
2. Please do a `brew install tesseract`.
3. Please do a `brew install mplayer`.
4. Download the screenshot2speech: `git clone https://github.com/shyamalschandra/screenshot2speech`
5. Go to **System Preferences** -> **Security & Privacy** -> **Privacy** -> **Screen Recording** -> Add the **Terminal** with the checkbox on.

Also, do a `chmod +x screenshot2speech.sh` before running.

**Example command:**

`./screenshot2speech.sh`

**Note:** All the files will be placed in the `Downloads` directory.  Please allow the Terminal to access the Downloads folder when asked by MacOS.
