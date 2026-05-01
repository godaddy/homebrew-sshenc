class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.43"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.43/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "23e6a849e373367898723416d70e1abe19402df4e945e9378b4a89a653904553"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.43/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "bcb9fae8a54b7b88b572839c55049644b2f22f4f36f9d240106cfd9b3f82835d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.43/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e6a6c84b0f593074f9e0d226f64134a926df12d6083f582293924ca25233e616"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.43/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "83c3a3b6c84312f30198c3079dac98888e18ea1fca6e9e42629e9e37454cdd2e"
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
