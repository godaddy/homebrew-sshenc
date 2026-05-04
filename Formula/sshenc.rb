class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.52"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.52/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "2e12e4dceeec655b3537edb1c8603e7a219e97d3794244efbb63e99b7f8cceec"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.52/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "2e4bf3e0de80c52006f8cbdc67eaaf62a54b2d53f16f13ce71aef8153123b56c"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.52/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2f5d40add109af917751f1f43ef065f6ea4d6c18e83333df0162047969e51ec0"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.52/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "06b15c6c5bf2c7bc0bdfa117b3fd2e807c0f2cf2ee2c3468fb2aa564167a83c4"
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
