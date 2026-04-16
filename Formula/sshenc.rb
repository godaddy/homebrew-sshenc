class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.9"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.9/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "12b678ea432d90aa1c89fe8d9ea6209f6ca9758a579f294ec0ed8d3c833cd5c0"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.9/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "bdc53f62c76690600bb225b4ac18e4673f6a1879de1cc4a70dce2000579859dc"
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
