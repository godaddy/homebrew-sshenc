class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.32"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.32/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "9ca6b2c74e3d5dc9bba84ede6166e0c6eed3e69d15e777fedf23800cef27cec7"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.32/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "0662344b3d2892f0383b357e2a1fe4e335616354979a45ba3db7ec16d00539fd"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.32/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d5a59aa8c9d3caab2a361a7bb1c357368b144ae7ae17b1ee739bdf7522326303"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.32/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "25dc5b6eaefaae182cb368f164fdf77564584d4e06d5be3bf1b8cca423005a32"
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
