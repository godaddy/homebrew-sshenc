class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.58"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.58/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "c3eb8e1590ad7a69fee614bbec1a8c3c7ca01e75bf7a54f03f2cdd9a13cf869f"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.58/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "88f71f3fc2dc337669ef74e16f926f3a7fc2f7ba7bc2462e1f279636e529852b"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.58/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d250896b971dd290aff719760091c868346a7b15b429595d5dfe954207629391"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.58/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "84268edf291212f41344fcf1e07788f4908174670e9ec1f7bdb744cf3cdde6c3"
    end
  end

  def install
    if OS.mac?
      prefix.install "sshenc.app"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc" => "sshenc"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc-keygen" => "sshenc-keygen"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc-agent" => "sshenc-agent"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/gitenc" => "gitenc"
      lib.install "libsshenc_pkcs11.dylib"
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
