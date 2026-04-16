class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.16"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.16/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "068552c9ab9f5520eef4d1e6a2c5332170f2f21389fcfde7eb0c93a32c95caf2"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.16/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "41a30d058ccc2360423f8a9687d11220daaa0d58ec63a5bcdd61e47cd8411e7d"
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
