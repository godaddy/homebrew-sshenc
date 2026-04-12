class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/jgowdy/sshenc"
  version "0.5.2"
  license "MIT"

  on_arm do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.5.2/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "4193269cecf8317b99b25da916cfcc117c1bc060502a581147c27efd3b78450e"
  end

  on_intel do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.5.2/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "4b374978a47e454ef4efadec92dc0d7e4aff539fd3f86a514edf197dc4fd91b4"
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
