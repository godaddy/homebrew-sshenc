class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.17"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.17/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "4960468fde8e6c85a6273cedd03224f53e237e19d6333c12fc59b416de723218"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.17/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "8c2035442d874d1cdd8a247b87d0228f8e78028c84ee249de6163e5c471fbe04"
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
