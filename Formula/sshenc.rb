class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.4"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.4/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "6c7cd976d4d1018df80fdc944a93488a2d83f894741f08be1370eae150ea9390"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.4/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "0ba5ae8d37a98752fd26d28156c18f551766846a54b1a221453ab41e5aeeeb7f"
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
