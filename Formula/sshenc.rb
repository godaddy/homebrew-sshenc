class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.76"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.76/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "536eb2086235e1e8a39d590be069d0b39b5a956077c28bc5a03bb835e9b4c310"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.76/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "3826a89d6e7be931ce7291be727e7d1e8b1adca812f2bb8426a8edf98eb90a45"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.76/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9d73c2a2c141e57e889e864583070228e5a4399eb15ec293bf43f94c77490dd3"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.76/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "25aacea7e4ba8479355ce1752d8e1ba7a1ba3a32771eb77c0737861f903ce7a3"
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
