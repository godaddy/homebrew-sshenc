class Sshenc < Formula
  desc "macOS Secure Enclave-backed SSH key management"
  homepage "https://github.com/jgowdy/sshenc"
  version "0.3.6"
  license "MIT"

  on_arm do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.3.6/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "08618209a4bc505ef60407fd0056da5060518cac619c17f966cbb570e8810f6e"
  end

  on_intel do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.3.6/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "6674b8b7472bb32eee79ba0e0de99d99d8c32cfbe850e0733705c592aa092503"
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
