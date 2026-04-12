class Sshenc < Formula
  desc "macOS Secure Enclave-backed SSH key management"
  homepage "https://github.com/jgowdy/sshenc"
  version "0.3.4"
  license "MIT"

  on_arm do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.3.4/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "6c7817ba75343355d651aa173beda23c12e81af739d63f0de5ece3ddaef032a0"
  end

  on_intel do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.3.4/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "ea71c71221fd6d074d132160990dcfa8ad5ca784bf552ed2de53e9c1369d5b1c"
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
