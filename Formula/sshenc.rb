class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.2"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.2/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "6a7187d9c6a8fe24e5d19edefa4d9c82b31f9b5430d2ddd28dfdb612c3fe3e5c"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.2/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "50abd6267501542cd1db47d3a68aa173a48cdfc09c700d9f6d0605fd1f9866c1"
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
