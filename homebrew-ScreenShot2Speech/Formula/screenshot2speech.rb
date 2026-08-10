class Screenshot2speech < Formula
  desc "Convert a selectable screenshot of the macOS desktop into speech synthesis"
  homepage "https://github.com/shyamalschandra/screenshot2speech"
  url "https://github.com/shyamalschandra/screenshot2speech/archive/refs/heads/master.tar.gz"
  version "0.5"
  sha256 "8857ee97de6e7e3d0e73776d1f5e296320f5e934df9da49bdd81a7766fbf9f3e"
  license "MIT"

  depends_on "mplayer"
  depends_on "tesseract"
  depends_on "liboqs"
  depends_on "openssl"

  resource "build_script" do
    url "file://#{File.expand_path(__FILE__).sub(/screenshot2speech\.rb$/, '')}/build_encrypted.sh"
    sha256 "47510c396461a6bb10bc7fa153807e3f8865c87d0ef81d02bb9c05a3e5ed199d"
  end

  def install
    # Compile the C code
    system "gcc", "-o", "screenshot2speech", "screenshot2speech.c"

    # Obfuscate the binary using LLVM Obfuscator
    system "clang", "-mllvm", "-fla", "-mllvm", "-sub", "-mllvm", "-bcf", "-o", "screenshot2speech_obfuscated", "screenshot2speech"

    # Install the obfuscated binary
    bin.install "screenshot2speech_obfuscated" => "screenshot2speech"
    chmod 0755, bin/"screenshot2speech"

    # Install the build script for encryption
    build_script = buildpath/"build_encrypted.sh"
    resource("build_script").stage { build_script.write(File.read("build_encrypted.sh")) }
    chmod 0755, build_script

    # Install the key exchange binary
    system "gcc", "-o", bin/"key_exchange", "key_exchange.c", "-loqs"
    chmod 0755, bin/"key_exchange"

    # Create a wrapper script that will handle decryption and execution
    (bin/"screenshot2speech_wrapper").write <<~EOS
      #!/bin/bash

      # This is a wrapper script that handles decryption and execution
      SCRIPT_DIR="#{libexec}"
      ENCRYPTED_BIN="$SCRIPT_DIR/screenshot2speech.enc"
      KEY_FILE="$SCRIPT_DIR/key.bin"

      # Check if we need to decrypt
      if [ -f "$ENCRYPTED_BIN" ] && [ -f "$KEY_FILE" ]; then
          # Perform key exchange to get the shared secret
          if [ -f "#{bin}/key_exchange" ]; then
              SHARED_SECRET=$(#{bin}/key_exchange | grep "Shared secret for AES-256:" -A 1 | tail -n 1 | tr -d ' \n')

              if [ -n "$SHARED_SECRET" ]; then
                  # Decrypt the binary
                  openssl enc -d -aes-256-cbc -in "$ENCRYPTED_BIN" -out "$SCRIPT_DIR/screenshot2speech_decrypted" -pass "pass:$SHARED_SECRET" -pbkdf2

                  if [ $? -eq 0 ] && [ -f "$SCRIPT_DIR/screenshot2speech_decrypted" ]; then
                      # Execute the decrypted binary
                      chmod +x "$SCRIPT_DIR/screenshot2speech_decrypted"
                      "$SCRIPT_DIR/screenshot2speech_decrypted" "$@"

                      # Clean up
                      rm -f "$SCRIPT_DIR/screenshot2speech_decrypted"
                      exit $?
                  fi
              fi
          fi
      fi

      # Fallback to obfuscated binary if decryption fails
      "#{bin}/screenshot2speech" "$@"
    EOS

    chmod 0755, bin/"screenshot2speech_wrapper"
    
    # Symlink the wrapper as the primary executable
    bin.install_symlink "screenshot2speech_wrapper" => "screenshot2speech"

    # Run the build script to encrypt the obfuscated binary
    system build_script, bin/"screenshot2speech_obfuscated", libexec, "screenshot2speech"
  end

  def post_install
    # Verify codesign is available
    system "which", "codesign"
    unless $?.success?
      odie "codesign is not available. Ensure you are running this on macOS."
    end

    # Sign the binary with an ad-hoc signature
    system "codesign", "--force", "--sign", "-", "#{bin}/screenshot2speech"
    unless $?.success?
      odie "Failed to sign the binary with codesign."
    end
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
