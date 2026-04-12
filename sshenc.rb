class Sshenc < Formula
  desc "macOS Secure Enclave-backed SSH key management"
  homepage "https://github.com/jgowdy/sshenc"
  version "0.3.5"
  license "MIT"

  on_arm do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.3.5/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "232f6d06c31cde00dcce69e35141dc24e4d5545b883474d8bf3ea9e822c783f7"
  end

  on_intel do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.3.5/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "109ccad93ae677b74113f399f37f87cd87a27366f8e0f6f1b2fb832cb948e572"
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
