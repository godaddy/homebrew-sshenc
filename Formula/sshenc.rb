class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.74"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.74/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "f92cb49d4f89b6838a3ef78521f7b535b20e78fce97633a7564a80e8ef393b51"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.74/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "58a17196110ddfde38cdb5fa38179d3bb50b4cf98fee841a8d52136378001cb8"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.74/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d62044026fd8f76b41948aeb3164b5268d6c14eea11579e48fedb83f9c8dff3a"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.74/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "49a1eaf030a04912e5ea58260399bbba460117c0f10cbbb00ee8cb857c5deff2"
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
