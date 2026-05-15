class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.87"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.87/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "03902cee261439c786a8bf16cbd15a79b81076ece437d1f999727769eebb10a2"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.87/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "8966a6acd7c392dfb38402bf3ca75812862ef2727a13f31d052fefaaba05f5c9"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.87/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8936562ee5bb64ef033a3ddaa3992c4635fe887a985a6db5ee8bea6bed48502d"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.87/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b26d90fe07ce884ec00ff69c46b605c9c0cde4052ce7500ba86d1d45f5fb4c74"
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
    plist = "#{Dir.home}/Library/LaunchAgents/com.godaddy.#{name}.agent.plist"
    if File.exist?(plist)
      uid = Process.uid.to_s
      system "launchctl", "kickstart", "-k", "gui/#{uid}/com.godaddy.#{name}.agent"
    end
  end

  test do
    assert_match "sshenc", shell_output("#{bin}/sshenc --help 2>&1", 2)
  end
end
