class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.86"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.86/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "2f1ae00418431b2aebc46b7d4d500fe0667da1c3f90b3dd949df71f965cd841c"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.86/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "bc1d31408b8d4c15dc5f6078eb93868391e734e0dd8e657402b3d82c18f5e6ff"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.86/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e67b497d475044407959aaf696d6036909077875e7351309b792dcb274aa9d76"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.86/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e6128d670b6d78f5db07d88208fd0ba311386674fdd91f6f72439b0955c92f1c"
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
