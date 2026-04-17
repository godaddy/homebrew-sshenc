class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.24"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.24/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "724ea513406bcdea0a48cf406d729876c95efb0032014ac675cba5580ad1ea78"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.24/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "2f642a2ada310553ffb1ead3199970c1bb32104c782a6579b8000ac1b0f2d5b8"
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
