class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.83"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.83/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "4ba369053cd28ff895b31a80319d834ac78392922684e1647e349f6b6db96e4d"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.83/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "94ec8adf3575dece086038ab259c061ea0058bf82e829e41e23eb62b55478d8e"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.83/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "445fd621e93f9152a2f9b5a58332cb9134b47372d02cb34a1cdb6e86ba6d0a56"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.83/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "42947983b5dfa8f7767371795cdc62964866e0505db86496e81e1af749860654"
    end
  end

  def install
    if OS.mac?
      prefix.install "sshenc.app"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc" => "sshenc"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc-keygen" => "sshenc-keygen"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc-agent" => "sshenc-agent"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/gitenc" => "gitenc"
      lib.install "libsshenc_pkcs11.dylib"
    else
      bin.install "sshenc"
      bin.install "sshenc-keygen"
      bin.install "sshenc-agent"
      bin.install "gitenc"
      bin.install "sshenc-tpm-bridge"
      lib.install "libsshenc_pkcs11.so"
    end
  end

  def post_install
    # Restart a running LaunchAgent-managed daemon so users pick up the
    # new binary immediately after . With KeepAlive=true in
    # the plist,  causes launchd to relaunch the process
    # from the updated Homebrew symlink automatically. No-op if the
    # LaunchAgent has not been installed yet (fresh install, or the user
    # manages the daemon themselves).
    plist = "\#{Dir.home}/Library/LaunchAgents/com.godaddy.\#{name}.agent.plist"
    if File.exist?(plist)
      system "launchctl", "stop", "com.godaddy.\#{name}.agent"
    end
  end

  test do
    assert_match "sshenc", shell_output("\#{bin}/sshenc --help 2>&1", 2)
  end
end
