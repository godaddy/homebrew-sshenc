class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.82"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.82/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "a70b457f444a27a5e81772e81d42c427614de781401002c8363f33af2f2da1d1"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.82/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "32a0039a0a9e80831207130948fc7f65b379517454ca295965d3ea058663b8ab"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.82/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c7bf7afb7da0cba68cf7e4d06d92d890c96f0e89c023cd1e215c22725f0f2c49"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.82/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d1a49cc8cd53d95d7c6034280697a857002ffb4abd4672d7066c899cebde5bb1"
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
