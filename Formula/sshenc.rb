class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.21"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.21/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "02299ab954fc885cc94d540a739896f7b4ed2943e04abede7c21f69dc998cfbb"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.21/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "9f413805161f81134804105466a19ff712dde1af122213a41fb1d6fbc63ff144"
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
