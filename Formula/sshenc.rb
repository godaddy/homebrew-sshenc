class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.47"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.47/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "5d93488b7502cd7a6132cea30faf3b1b9e02c1a52fa319cdaf0df4088a5b0245"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.47/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "fb3a72bb8338fbd578ad5f60a91978b4f3f21b2115647891032a79e2db158b9d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.47/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ad1d498667cd25b2da5116cf778c5bbb206496b5f2ce1a4ee76c4de85fd2cda7"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.47/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "07a85925a7a9263c2b8b5cc8116c5c3aae1a68cb55939aefd3575e92542f9e13"
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
