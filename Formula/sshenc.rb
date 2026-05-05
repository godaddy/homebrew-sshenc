class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.57"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.57/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "792259a2df4b89934a35388fa4fe152370e6c5ce31213f6408d69806df3423b7"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.57/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "e2e191a4010ea83cb1074bffab8a46cb0612f49ed2eaea024aa1a82480f3d87c"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.57/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a71bf68aeb55ef8d83aba97b138ebcff27320345be0a05b244670373ce4d06d2"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.57/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a557268d41628ef9f688cd8a838896eef938439736bc13f8530c374b2afa9e99"
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
