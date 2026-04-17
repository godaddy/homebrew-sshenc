class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.22"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.22/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "5b53d08c324808bd99f5fd13cdffffd656e663d90f68546cc3deedae31c5e1fe"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.22/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "3bb7ed5758f76ef6848cfc52c49c9ac57395dd59d7b9be71ab80b90e49c7a9b0"
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
