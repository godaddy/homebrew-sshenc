class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.71"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.71/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "fce16a2a10bcfe427fc8c1fac3875593730c0ed57feb6d292b5ef9274f6d4054"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.71/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "75ac3ea72a210110c30135e5c7711c007b87613a7cdbc6fc14b285ea99a99347"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.71/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "089d884a9f12c3e8abd285e97c7873bbd663aa4ee163b629307d98e09451514c"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.71/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "34fd4a196c997cd95ced1f4993bce23f83cd7309b7bce785579fd415fecd7fc6"
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
