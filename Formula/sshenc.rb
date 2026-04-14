class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.5"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.5/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "b51d018ad6582ad702ce96a7339d56b92fea3af9b979408f03979f7c700e3cef"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.5/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "a3d2c649c32a1843526112d4050699407c27b2d7bba472c9531e14eb827cf032"
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
