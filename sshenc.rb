class Sshenc < Formula
  desc "macOS Secure Enclave-backed SSH key management"
  homepage "https://github.com/jgowdy/sshenc"
  version "0.3.2"
  license "MIT"

  on_arm do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.3.2/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "8aa3b2a37a9766f0b5afc21c15bc4a83eb5f8e69fa5186770018cd78b5690d36"
  end

  on_intel do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.3.2/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "8beeb6107108f86f0cca6fe59d368ed07cd7d77bed83035209c0ef1f81d2c9c1"
  end

  depends_on :macos

  def install
    bin.install "sshenc"
    bin.install "sshenc-keygen"
    bin.install "sshenc-agent"
    bin.install "gitenc"
    lib.install "libsshenc_pkcs11.dylib"
  end

  def caveats
    <<~EOS
      To configure SSH to use sshenc for all connections:

        sshenc install

      The agent starts automatically when SSH needs it.

      To generate a new Secure Enclave key:

        sshenc keygen --label my-key

      To remove the SSH configuration:

        sshenc uninstall
    EOS
  end

  test do
    assert_match "sshenc", shell_output("#{bin}/sshenc --version")
  end
end
