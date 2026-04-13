class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.3"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.3/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "72ea6090d07f04fad395102bd09ba26dd0dd9e2a0a61274a29d64c22806585b6"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.3/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "d0baa1a9f748fa712c122422fa4bfaf1b0d4a96d8c7e0456736aefe8ed519063"
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
