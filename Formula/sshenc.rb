class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.33"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.33/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "eeff1c4813db69ee8a95ccd4e7fb7180ad928a1486ac0ca07e0b34d3df4122d2"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.33/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "098412a06efe57431b2c8679dfb621e4e22fb96cab2e435d296f5c2a772e209a"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.33/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e93d6c3baee9fde4ab4714e6ac1dc697273a6d9fa9e9de243cd93c5e65c335f3"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.33/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c21b4a2634b46eeb678cda53cd8eebee822129cb8e680d71da64f5d946154f13"
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
