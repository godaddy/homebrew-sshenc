class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.6"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.6/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "39bd16db72136a5af62562a30b6b8b9f239c2410200435b7b2636242fd44487f"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.6/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "221d4185390e14852de4f6f3109308e07719d69ec07c5f0d12679b5b0438a39a"
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
