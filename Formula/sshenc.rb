class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.78"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.78/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "e76717179d86f562c36c2aa04149d81bb1e5ad703d35858839bc2b99a2e61440"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.78/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "c7f6211bf29a39bea4e60432b514ce90dfc0a3f9cdc03d6ae17ab79095b17ce9"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.78/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8c3297ed0ce8e286660da4610b331fefa93bdeac7ab81efea0e666d71af76126"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.78/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c295c7978b313ebd0351a61bf396440798b9022b99074fc23ebef9defb4c1bfd"
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
