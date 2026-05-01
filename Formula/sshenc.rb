class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.41"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.41/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "ba463384a2f27059a867ffeda49b6396656d162c2768790e706f4381b7ffa503"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.41/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "1c241ff1d0cbf5d87593feac0feb9017ecd6b3ab71e20f94bacaa22eec1a1702"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.41/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1d27ee3e22059750457d7535958525fba46f2843b5be0d1dd85ac8caf842fc19"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.41/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "24edf44e199233a7883549c28cdf66ab3c612a6c82e6dbd5d04632a184f5af21"
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
