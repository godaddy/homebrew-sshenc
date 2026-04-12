class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/jgowdy/sshenc"
  version "0.5.0"
  license "MIT"

  on_arm do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.5.0/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "b8aae7961a37f649137bc4f733b1c5417da458fc65414ffbe1f3af4eeab294f9"
  end

  on_intel do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.5.0/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "3dd0fbc956059e314ca659693a0ad6c1d12cd87026a886c0db14caccfc744041"
  end

  depends_on :macos

  def install
    bin.install "sshenc"
    bin.install "sshenc-keygen"
    bin.install "sshenc-agent"
    bin.install "gitenc"
    lib.install "libsshenc_pkcs11.dylib"
  end

  test do
    assert_match "sshenc", shell_output("#{bin}/sshenc --help 2>&1", 2)
  end
end
