class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.18"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.18/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "45d5a62812ea88de09ac204d615bdf805e152647d137997c5a4c06812d4f6029"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.18/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "99af82ada2c2d754016b9dc8c7faa28c5d9cb8519cac745a787bc78cccfc2de6"
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
