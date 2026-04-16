class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.15"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.15/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "d02ec20d334bb8d240939fdfbc686e595333d06bcecbc180631b22740d980aa1"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.15/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "7a08bb275a632a312b32e064d7f78789dbc055c34f71206b2d7a6dd1fb0feaa1"
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
