class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.30"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.30/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "fcd8c207affab99cedb0fc1d05c3081bb261c4978d339cd5eacaf3021383ee4a"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.30/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "883237e94213655f5d557819dec95109416c26223534e12d7a95f5828a8a40f6"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.30/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3f6c36413fe8d56210d57cb26574fa175da7bc9c22403fbfa25799034db40ea4"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.30/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "215bdff56a0efd42632553f4514c087e12fb956e536dab4c62714d73bb36733e"
    end
  end

  def install
    if OS.mac?
      prefix.install "sshenc.app"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc" => "sshenc"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc-keygen" => "sshenc-keygen"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc-agent" => "sshenc-agent"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/gitenc" => "gitenc"
    else
      bin.install "sshenc"
      bin.install "sshenc-keygen"
      bin.install "sshenc-agent"
      bin.install "gitenc"
      bin.install "sshenc-tpm-bridge"
      lib.install "libsshenc_pkcs11.so"
    end
  end

  test do
    assert_match "sshenc", shell_output("\#{bin}/sshenc --help 2>&1", 2)
  end
end
