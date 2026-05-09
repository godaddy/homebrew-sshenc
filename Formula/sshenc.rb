class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.72"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.72/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "64b930cbbe37a37c2acfebabd3925963b39702f49b38940566ea2603db01b929"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.72/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "7b3112041475f2df373a8f378de9fff392fdf1e80f3a7ba497662c9716fd0701"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.72/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a5cdb1921d3f404d2b00e5db5d99e31006a4e725e247725f1eea92fa024017a3"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.72/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "156af8744c6964b9fa435ae4258410a3042676abf90ab0ced7643f9076e65460"
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
