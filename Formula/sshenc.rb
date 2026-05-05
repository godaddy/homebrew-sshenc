class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.59"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.59/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "f352bd2b078a838beb3dc157de15a92d62a2e9c4017c5b5ba56880e859ebf623"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.59/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "07cff61ce13f4feadbbb584c2d1509d0ce37ba5e02691a17ce50fbca10f43ba0"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.59/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "22f4514a37d1090d1346d785abc7acb666c1f1901b54c59327b1e92ed2f37182"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.59/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5073df1b1660d15cecaebc8b4495b9dec1adcaaad1b79bf6e9ba55de303e3c10"
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
