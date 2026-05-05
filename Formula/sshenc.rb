class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.61"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.61/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "081bd1054422886c01b3c0e0407654de991fc31706f8c5c24c9876e15fc45fcf"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.61/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "3abca66dcfb900f0c46f2f9bae3a7f83fab24fd86e2f639b48405307de99e25a"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.61/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2e72ac416b8cb91faf6de79c8a2190ec74dcadd1134af785efdcf8e69355fdd5"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.61/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5a54aaa3e2c28e06a12ff13421114a03b83ffef594e39cc9e8c7a7b9dbfb656e"
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
