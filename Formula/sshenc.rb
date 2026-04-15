class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.7"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.7/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "8103f0b8aba6bfa2b0f31b939b9e8a3fc54095a79d7bf41a5a5a5aa910ba8f2a"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.7/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "a99d1e1cb8d53b21b4dac33777cae56aa8a9f5d5a87746f53bfdcf8b2371ad74"
  end

  depends_on :macos

  def install
    bin.install "sshenc"
    bin.install "sshenc-keygen"
    bin.install "sshenc-agent"
    bin.install "gitenc"
    lib.install "libsshenc_pkcs11.dylib"    end

  test do
    assert_match "sshenc", shell_output("\#{bin}/sshenc --help 2>&1", 2)
  end
end
