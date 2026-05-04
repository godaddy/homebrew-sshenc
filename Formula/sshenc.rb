class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.54"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.54/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "82bfb500ff3986b9d9b0abc5bfe85d0223fbf7e3bcba48733ecbc1b05be8d6b2"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.54/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "72ed8223a3906aef4f5f5c00235de73e4d8268502d38bfd068fbc4c3e5876252"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.54/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3318ae1f1fdca6bdd9b0c477777e460646af55c3caa1cc9999060aea5bd837e7"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.54/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ff949c2141580d20c6e89c80769430838c265064ffab7e8e90496883652e36a9"
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
