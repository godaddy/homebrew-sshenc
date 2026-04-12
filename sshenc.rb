class Sshenc < Formula
  desc "macOS Secure Enclave-backed SSH key management"
  homepage "https://github.com/jgowdy/sshenc"
  version "0.3.1"
  license "MIT"

  on_arm do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.3.1/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "219d67de181eaa9df97a02b7690c0c337ead805d30e6ceb5a1bcf4646bd6e637"
  end

  on_intel do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.3.1/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "66b490ffd5ebc82c08cab9c8c8f8aff1fb4cfb447504e1b89df59ce6050eb18a"
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
