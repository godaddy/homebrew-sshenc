class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.67"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.67/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "341f1bb6d389fc46029a8e4ff8a195825eab64e84394cb08b2247af6158fc177"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.67/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "fc4a93b0a33e1cfea6278c04bd1926cbe468b64da061e0eb84661aa4172d1566"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.67/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "496bdf3a247f3d347d02a93abc92ee67fa1b1882229971d3e5e43951c0045e96"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.67/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bc2d66eca6d72f753687d7f63b1ccabae851f21a2abe20f2463fbe743ee08ed0"
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
