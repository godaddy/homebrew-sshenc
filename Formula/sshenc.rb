class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.29"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.29/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "49da1cad60e32cfe487a1d752d830e58a65a552409b184a47649cc030fb6aec1"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.29/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "24e564cbb39ed56333b286f981fb0de9aeae3f4104259c55f79e679205499463"
    end
  end
  on_linux do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.29/sshenc-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "2e92acea51947be2bb6c3716ed5e97d63fe3b6fb428989f3e0e35a5b98a47ec3"
  end

  def install
    if OS.mac?
      prefix.install "sshenc.app"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc" => "sshenc"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc-keygen" => "sshenc-keygen"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc-agent" => "sshenc-agent"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/gitenc" => "gitenc"
    else
      bin.install "sshenc"
      bin.install "sshenc-keygen"
      bin.install "sshenc-agent"
      bin.install "gitenc"
      bin.install "sshenc-tpm-bridge"
      lib.install "libsshenc_pkcs11.so"
    end
  end

  test do
    assert_match "sshenc", shell_output("\#{bin}/sshenc --help 2>&1", 2)
  end
end
