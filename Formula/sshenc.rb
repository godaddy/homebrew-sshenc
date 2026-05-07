class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.63"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.63/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "47d6670741dbdc5b13faa6495e953b00c430e5ef874963b918cd3e6329c88258"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.63/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "6a49086c68fe6436a11ea83f53550c42bb2417bd5f5693a3764606560c995eed"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.63/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "59845e9ba479167e303cd9a993d9c760d20721fd688e0aba01db8b74c4f2aa53"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.63/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a7a4175e9d42f46646bdd8a02cf1d0304a39365fc7417f6af7967d127a85bc0d"
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
