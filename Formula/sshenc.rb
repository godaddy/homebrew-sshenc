class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/jgowdy/sshenc"
  version "0.6.1"
  license "MIT"

  on_arm do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.6.1/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "e90ac9d672b8eeb30103d6ad3e77b284c90484b09ccf60a8205198e70962a705"
  end

  on_intel do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.6.1/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "0e970131269e5aaf530bb03ccd6fd499324a4e9cc7841e9f1c2b28557e92d904"
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
