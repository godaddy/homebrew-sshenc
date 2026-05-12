class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.79"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.79/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "8bc3ec27424a876447cb2089c38aac596eaa0f285dd3a960d1f15892aa973c62"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.79/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "97495a24cfbb1ea2b0b7af51a0e11d616170d3180045800023a7f7a739c8dd5e"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.79/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "184d7d005822b28fa28eb2a87c276473057eb40a1a9b7599198e329e6d264207"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.79/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "62c12a8b1bde3c49fa8c0b083ac3483370fd0180e35674d153d7368c2fab04bb"
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
