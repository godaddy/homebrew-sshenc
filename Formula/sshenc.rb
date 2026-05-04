class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.53"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.53/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "c333a013c00865f91612fa5802b02a9de8e419ac9aba794988c49e33e619c754"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.53/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "3001dfb4b5bed37b72349221fdc95c8646793049b3e6f373e38a87b1046899d9"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.53/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2f11f524688b1a54345894f0997a086eeceaf7a95e9aeaa51c68b9ae7001bd16"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.53/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "675a6ecab06cdec7bb8f85403cdc992a7db5e106a9548cef90d4a24c9f22febf"
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
