class Sshenc < Formula
  desc "macOS Secure Enclave-backed SSH key management"
  homepage "https://github.com/jgowdy/sshenc"
  version "0.4.0"
  license "MIT"

  on_arm do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.4.0/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "dd82fca2dcc1b5e6d2ae20b6517aeba823d4f07b7af9f1d385df71f222b452b7"
  end

  on_intel do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.4.0/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "6ab81f017e6aad858a97e08b5d11b04ba8c8431a74ae71b835f9a4522617947e"
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
