class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.55"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.55/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "f21500d9d8348e3382f830a9ce0c3a50c39bbbc20a6434e4f888fa896a3686ee"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.55/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "d3d4e29e2127a39a805fd93c195c74cec41b3bfabba99097bb3703bb6cf83436"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.55/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ed25fcad5a5bbad52c210958752fcf9bcb0af87f139c00ec40c717b11c89fbd5"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.55/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e4bbc601c5a25c6d6d4df91c64e1de1c71d67ed7207e12610a12f5d493831ab4"
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
