class Sshenc < Formula
  desc "macOS Secure Enclave-backed SSH key management"
  homepage "https://github.com/jgowdy/sshenc"
  version "0.3.7"
  license "MIT"

  on_arm do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.3.7/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "12db716433c1026c6cc825b9fde4ca62f79d180572e796f44b874cca3cbd7412"
  end

  on_intel do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.3.7/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "74c080f2d13d3050d49d746c0e1b689ff0b9eab1c9a42da08037960c7918b60b"
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
