class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.36"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.36/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "3974facbeda7e09d98729085e7a03e3578d648c091ad7508fb082b695997c0fe"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.36/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "180abf20fa01f7d177bf8a3ebea8d57fecbb7abd4d51e5c15275d3b88272d9eb"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.36/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fcd8b21b9c61934eccece0528e26cc64660a49cb8997c2ae37a0cbc46ab67a50"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.36/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9af7352073b96cf5213b974334befb64e41842b9daad0898c77f6fc864415a3c"
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
