class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.10"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.10/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "50e6a0cc63fbac4df9b66e42681b29ce2d7a29f0d2e1246d063e7dd03ab78331"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.10/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "1346c6666988bf05dce29122be73e217fddfbc46daff9e426b7ee8034cb05802"
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
