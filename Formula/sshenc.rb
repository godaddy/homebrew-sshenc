class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.23"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.23/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "37fb493a0171bc629db6804bc2c8ac9784496a4b274d35884ff39feaf927ce70"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.23/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "54bdaf2c85d1a57563bc42c4b789f3839ae4f96ebaa9ed19f2b070c6b59b6a08"
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
