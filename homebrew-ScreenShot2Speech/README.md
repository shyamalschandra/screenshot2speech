# homebrew-ScreenShot2Speech

Homebrew tap for [ScreenShot2Speech](https://github.com/shyamalschandra/screenshot2speech).

## Install

```bash
brew tap shyamalschandra/ScreenShot2Speech
brew install screenshot2speech
```

## Usage

```bash
screenshot2speech
```

After installation, grant Screen Recording permission to your terminal in **System Settings → Privacy & Security → Screen Recording**.

## Maintaining the formula

When releasing a new version of ScreenShot2Speech, update the `url` and `sha256` in `Formula/screenshot2speech.rb`:

```bash
curl -fsSL -o /tmp/screenshot2speech.tar.gz "https://github.com/shyamalschandra/screenshot2speech/archive/refs/heads/master.tar.gz"
shasum -a 256 /tmp/screenshot2speech.tar.gz
```

Then bump the `version` field and push this tap repository.
