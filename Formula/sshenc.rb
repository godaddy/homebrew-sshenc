class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.11"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.11/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "1dd27627c154b6e5a7071a3e2cbf26301837115433df135eaf607acd8f4a5d6c"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.11/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "78340c18779f7cb50b70a945521ef20b82c1355b61066a7f471bceb98bf42b1a"
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
