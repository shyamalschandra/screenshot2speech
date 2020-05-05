# ScreenShot2Speech for macOS
## Version 0.2 (for macOS 10.15 Catalina)
### by Shyamal Suhana Chandra, shyamalc@gmail.com

-----------

**Purpose:** This bash script for MacOS is used to convert a selectable screenshot of the macOS desktop into speech synthesis inside a command line prompt with interactive speaking and highlighting of spoken words.

-----------

**Prequisites:** 

1. Please install Homebrew with the following command: `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`.
2. Please do a `brew install tesseract`.
3. Please do a `brew install pkg-config poppler`.
4. Download the screenshot2speech: `git clone https://github.com/shyamalschandra/screenshot2speech`

Also, do a `chmod +x screenshot2speech.sh` before running.

**Example argument list with the command:**

`./screenshot2speech.sh <Words per minute (e.g. 200)> <Voice Name on MacOS (e.g. Samantha)>`

-----------

**Final Step:** Go to **System Preferences** -> **Security & Privacy** -> **Privacy** -> **Screen Recording** -> Add the **Terminal** with the checkbox on.
