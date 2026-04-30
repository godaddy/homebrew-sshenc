class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.31"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.31/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "778db517f4d9285c40eafd997210eb184b6f6df909e8950efe60578ae794a90b"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.31/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "92463bee3d93578b5e14f946a030ced00ddc464e05854c9c9eabe2a5f347eb9d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.31/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fb77bc81d03242d2b772b92ffe9baf08d2e3d43f8de57807e43d551bdc109240"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.31/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9456a4baf53a67b74d3b2cdf5ec4dc4f159c23384285140280a6dc472cb6ceb0"
    end
  end

  def install
    if OS.mac?
      prefix.install "sshenc.app"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc" => "sshenc"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc-keygen" => "sshenc-keygen"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc-agent" => "sshenc-agent"
      bin.install_symlink prefix/"sshenc.app/Contents/MacOS/gitenc" => "gitenc"
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
