class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.25"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.25/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "0d3b010f42964b1673ef7c68a69445289dea30f58e7dbe36f8f074c7bc33a5e4"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.25/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "cdb45a8cd0e1dce5784a7b3546fd2b8623f0e49920e1df4847b7c8bb61138c25"
  end

  depends_on :macos

  def install
    bin.install "sshenc"
    bin.install "sshenc-keygen"
    bin.install "sshenc-agent"
    bin.install "gitenc"
    bin.install "sshenc-tpm-bridge"
    lib.install "libsshenc_pkcs11.dylib"    end

  test do
    assert_match "sshenc", shell_output("\#{bin}/sshenc --help 2>&1", 2)
  end
end
