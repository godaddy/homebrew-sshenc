class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.20"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.20/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "af05b97e73b666361613ab268ac4f84d77908358faf999fba4e19fbe8ece25e4"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.20/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "1bba25f7a5f6b3d74557d5f2a2a40fce8796a9398a8e521115f50e799016d1b2"
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
