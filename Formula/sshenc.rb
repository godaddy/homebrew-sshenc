class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.48"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.48/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "7181fdacba0a8da1c49d613826185c3ef74c8d4b3043a447dd80163c67fa648e"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.48/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "b446ef1789e922b1f6e0b5d3a3a74fa22f9553e058690192851b05e483fb05e9"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.48/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "57742dcd452f73f35da02997b3569738d1359eccdde55dd21db380f214acf038"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.48/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "954fddbc6fd163dcb2ac2b1a585e0493545301093df35fa94720a9528bdc91ed"
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
