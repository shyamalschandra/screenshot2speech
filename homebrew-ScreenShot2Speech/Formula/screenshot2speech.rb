class Screenshot2speech < Formula
  desc "Convert a selectable screenshot of the macOS desktop into speech synthesis"
  homepage "https://github.com/shyamalschandra/screenshot2speech"
  url "https://github.com/shyamalschandra/screenshot2speech/archive/refs/heads/master.tar.gz"
  version "0.4"
  sha256 "f76e9a3a1c6f4616fb06d7bd86041508e64dbeb4e875b2fb44b05a2669fffe43"
  license "MIT"

  depends_on "mplayer"
  depends_on "tesseract"

  def install
    bin.install "screenshot2speech.sh" => "screenshot2speech"
  end

  def caveats
    <<~EOS
      ScreenShot2Speech saves files to ~/Downloads. Grant Downloads folder access when macOS prompts you.

      Screen Recording permission is required for your terminal app:
        System Settings → Privacy & Security → Screen Recording
        Enable access for Terminal, iTerm, or your preferred terminal.
    EOS
  end

  test do
    assert_predicate bin/"screenshot2speech", :exist?
    assert_match "screencapture", shell_output("cat #{bin}/screenshot2speech")
  end
end
