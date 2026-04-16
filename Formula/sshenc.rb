class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.12"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.12/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "b5dd20998d1b6c372dad6a315d4e0bd751a560229f7eaa541776b1715ddbe4dd"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.12/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "d6a81bbe0389c91bc7b4390376c60e787c1a8ad8bb21f7f4e3086113e890b07f"
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
