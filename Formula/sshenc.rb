class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.38"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.38/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "d93b4ff58bd3b8c36dc36ac5ef09cbf4fcb55bbcc82a83528b00024102fb35b6"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.38/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "63998987ca1acbc729ad03e9c9ea342f1ab9b8dbbcbf37b192a6567c84bbd3df"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.38/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "33a86191889e5ec615d19ae44cfb031137858a3773e7efcd27955fb310603956"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.38/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "118aaca97818cf0b299a73c7280a4eb3bfa37572f284aef2586a92b9b19ef696"
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
