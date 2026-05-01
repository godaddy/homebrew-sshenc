class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.49"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.49/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "2e214ea6fc5f30e1d01eceb31c4f69772ebf2bed6c044df6a6efbc0f98522ef6"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.49/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "9fd5e0a651d899b8111e53cf246b298a0fa2090cc556ada3fba3fe368f67b12d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.49/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "75589497a28a4521aaa274bc1d2a9397e5ebfdba637b860568778b245f552962"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.49/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "787d76f217fe7b6ca475794a91aa9d6e9537b06d9715b3cddd4ef22ba9dc952c"
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
