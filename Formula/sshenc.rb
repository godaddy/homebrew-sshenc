class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.84"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.84/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "9c47a60a274e7fc354d3330469b9618e64a5841696f5e40fe3092e6f3c76c5cf"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.84/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "f34b4c6b38bd8b1c9caa0b3dca65284e1568e35bf952e65d0c35348abb5d551c"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.84/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "284d601cd60367f644dc308c919c31af631158bd9c973bf10f411afa002cfb92"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.84/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "73b02728659f08bfb29e3aaf2023bb28778c9c620487a530078a38d08ead8b5a"
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
    # new binary immediately after .  kills
    # and relaunches the service; with KeepAlive=true launchd always
    # restarts it. Explicitly targets the gui/<uid> bootstrap domain so
    # this works when brew runs in a background auto-updater context
    # (which lacks the default user session domain that plain
    #  targets). No-op if the LaunchAgent has not been
    # installed yet.
    plist = "\#{Dir.home}/Library/LaunchAgents/com.godaddy.\#{name}.agent.plist"
    if File.exist?(plist)
      uid = 1001.strip
      system "launchctl", "kickstart", "-k", "gui/\#{uid}/com.godaddy.\#{name}.agent"
    end
  end

  test do
    assert_match "sshenc", shell_output("\#{bin}/sshenc --help 2>&1", 2)
  end
end
