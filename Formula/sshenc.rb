class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.69"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.69/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "2e25b057b3f854765d011e30f3c6942e48cc27cf364b6f41540d74e741a1d825"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.69/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "a4ec0308edfba61d740e8a0b6098b480855ab14fedcac717817d05e654148b2d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.69/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "953d645c97524f4a762642925dd8bc308c2b00a70ad241c30792c454159ad69f"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.69/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "546dad97b788883f1522fab5a4fe151703897ce364050eb9529659b1d0c183ca"
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
