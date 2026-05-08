class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.65"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.65/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "6a5e73b60a7e34ad4a197a92c8d6c006fc9341a787828254a61a436b763506fc"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.65/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "08032c3a89cbaf89ee0a92f2101b07eed49ff4f3293cc5aa99c64c1dc8b99a1c"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.65/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7ee5df2a3956de760634d9bf8fbef4a3d06102be85c04420cc387eb61326383e"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.65/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7465a9deaa22ca781cceca082b7dceddb4d9d2797646ff9951fe4cb440f8a0c2"
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
