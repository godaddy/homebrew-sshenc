class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.73"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.73/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "6482dcd9ae0d2f0225b16a4ea7d3d22b99fdcde3e14d2a139f8a20bac6eb5ec4"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.73/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "64e47a575737388a760cb32e9a980e27978fc0cd410af422e95d26d1351ac271"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.73/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0694e6dbab280fd164398acd533cb7dd835fe4208b7e478f80fa36973ec2e621"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.73/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7a891cf444d8c24ada3a13e627dbbbd5d9d449a5881f0f384f83f6e9a63daa62"
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
