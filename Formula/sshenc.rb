class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.64"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.64/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "e808a42837e030d9109adf2f663abcd9e9f1978aef533325b87c135177c45a5d"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.64/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "b286c8465d81a090278fe7a369bd7d2ec7d4d50e29aacb64d7353820581e35f2"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.64/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e5d3aed752bc7a2832db5e94c9e552f2715ca4d84db3ede02fb643222a2609e8"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.64/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7ffdbf759fe94a943e6d83710802ff22da78674a54db086de587374fd1fe8751"
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
