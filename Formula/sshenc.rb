class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.13"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.13/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "f8fbe2ca0957cd2ec7ae6fae31ed78986922b15fd3ff01c3c9b9c0563b91f0e9"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.13/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "177e234c5349cd051eb16607c18b9ca29e783ac3e7afd0240174a53a9bdd4a6f"
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
