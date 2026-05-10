class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.75"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.75/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "56f765d6bbf7d38d0fce253652e91a9ce0ddf51189f0b0af198aba70536c70c5"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.75/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "ce90b7c7a8c9a5971e9597a253988cc23c04ace13c4f6a595540b55edcb7a04e"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.75/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5d972b22ac018fc301588b1de70fb583799c58ecf3a8cb406ba57ecbf30fc203"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.75/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9828f860b3210fba71f8956460aeee833ce2a51e72c8901b851cc0a5b424a678"
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
