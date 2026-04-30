class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.34"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.34/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "23a962e90326a0894649baf7c5ba0a3dadaa054621659a0665fa48de2f1d40a5"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.34/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "5a7106b7ce6702818551f600c91e3e950a5eb5d0d4339f01c076454161432aec"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.34/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9064c9a8c30ac441935aad472a0f53f91e515c1eaafec5a5d8eb15a68a2bc76a"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.34/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5c68f3bc2fc13bb1107c091ef2021caabb73aa6b711cafd4767db7af9460c2f1"
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
