class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.66"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.66/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "3a0df10528431b693b1149e33203f630b1a481e8e7f23883f079961848068a3d"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.66/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "0cebd51ef437b24d6ad1a7f096a87759034f3982bbc8ae34e8dc7d0bdb3fbe8e"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.66/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "abeda29e21fdbb8e03bc3b566ea5f2735d08f1dd0b459019883dd645ea26541a"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.66/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a1fff2351e64f4f7a42d72131ac758a14069460413e03296dbaf998136bce255"
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
