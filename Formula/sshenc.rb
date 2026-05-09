class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.70"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.70/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "14b15bda6f290c214bc200e2980bf9df1d0b0610396c8e68947f8765ae8be5e1"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.70/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "41df0d7f6b31f3a7b6100db6d84bbb6b5057d504a58d516d0e78356f20ccc408"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.70/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7d4ed4e11c8a6e9531d535d08918310af59f77774299d7623d970dd69ec35132"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.70/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "975037734189d918f6e2eff7db9bde6bb29015b160b4e70a912eb2be4a154cab"
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
