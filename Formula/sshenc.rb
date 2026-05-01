class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.46"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.46/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "d0c4411bf88479e6559005cd969feb39e9d4dd395c458d120beb0c58b296cca9"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.46/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "155ac59fc27a3e22bc6d098773875dcf62cd6666a1981792e6d9ec296103b67b"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.46/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e4a9fe2faffe5abe804ebefaac0af9b9aa82439de217e4e9e055358da44f951d"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.46/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "23ce46179de29c3b834280c5f658e965526b56033ac19c8b5e6d45604728400b"
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
