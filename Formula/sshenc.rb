class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.44"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.44/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "88fe8b4657990a9d6549b95209d2f7b9d4354d19a2ae29667c44373825a51064"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.44/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "990b1dfa67b0d3e449642eb9ecab1b6ad025a746f42a21f193727452780ea06c"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.44/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e889c7afb7273597cee5185ef2683375372d0128c80c01d38f0ca5fc5bf4ae24"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.44/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "64d792a75c4f98f62cac3717117ca446bebc633fef16aecb8b36bbff9e7039e7"
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
