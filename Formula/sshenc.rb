class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.85"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.85/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "6291ea52cd68fad7c1b7be9cd2b0f90ae03a9f4caae424a0f1cc1d88ab0a40d0"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.85/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "9ca237dbb6f47505ece4f61846ccefcba8a4ab74d7671552f1404a23f28a179a"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.85/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ef230d4c863d0dc3f85686e65c901c7d088cf2aa4d043f96396af4832f56146f"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.85/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "36ee4a1e7c20df1b8a1aa3edd1a645a78cff26740a81c06fbb33f64631c0eda3"
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
      uid = Process.uid.to_s
      system "launchctl", "kickstart", "-k", "gui/\#{uid}/com.godaddy.\#{name}.agent"
    end
  end

  test do
    assert_match "sshenc", shell_output("\#{bin}/sshenc --help 2>&1", 2)
  end
end
