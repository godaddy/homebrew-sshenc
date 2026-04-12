class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/jgowdy/sshenc"
  version "0.6.0"
  license "MIT"

  on_arm do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.6.0/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "20dfc75d02624aaf1a391b523500a91821bcf86d3f42bcc6a339154bb44ba3bd"
  end

  on_intel do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.6.0/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "dba8b5e1fe6fbd4b4a17cc84177a98d5420dd6815d204d9f57169460c49e8478"
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
