class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.40"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.40/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "1673814f2733fbed7275701b9c1e1a63007c8cc93da3fe54580304e6815f20d5"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.40/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "744535535e06b81a9aa05719729aa00feabef05f9c1b04be4a0254989747e8c2"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.40/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a95534179f8b92340a067e9eca9a3d23f95cfb26a9ffb4c69032048282580ec9"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.40/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c42abc608475c5cff2251e7e66b3a8d2e9513a4bd1e252735c1c4a91f3e13b84"
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
