# ScreenShot2Speech for macOS
## Version 0.4 (for macOS 13.5.2 Ventura)
### by Shyamal Suhana Chandra, shyamalc@gmail.com

-----------

**Purpose:** This bash script for MacOS is used to convert a selectable screenshot of the macOS desktop into speech synthesis inside a command line prompt with batch processed speaking using mplayer.

-----------

## Install with Homebrew (recommended)

```bash
brew tap shyamalschandra/ScreenShot2Speech
brew install screenshot2speech
```

This installs the `screenshot2speech` command and its dependencies (`tesseract` and `mplayer`).

After installation, grant these macOS permissions once:

1. **Screen Recording:** System Settings → Privacy & Security → Screen Recording → enable your terminal app (Terminal, iTerm, etc.).
2. **Downloads folder:** allow access when macOS prompts you. All output files are saved to `~/Downloads`.

## Manual install

**Prerequisites:**

1. Install [Homebrew](https://brew.sh/).
2. `brew install tesseract`
3. `brew install mplayer`
4. Clone this repo: `git clone https://github.com/shyamalschandra/screenshot2speech`
5. Grant **Screen Recording** permission to your terminal in System Settings → Privacy & Security → Screen Recording.

Also run `chmod +x screenshot2speech.sh` before using the script directly.

## Usage

```bash
screenshot2speech
```

Or, if installed manually from a clone:

```bash
./screenshot2speech.sh
```

**Note:** All files are placed in the `~/Downloads` directory.
