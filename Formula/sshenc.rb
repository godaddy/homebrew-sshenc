class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.4"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.4/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "88fb9fcd6c50df843f957189644d30c1142f5850b1d3058033374aa14c34fc68"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.4/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "50caf6be3943c7fdf30c10f5ff1b2e7cef9df496fe576e5ae68ab9ee8f6f1235"
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
