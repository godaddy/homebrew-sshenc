class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.60"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.60/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "6c424ed10a2a8436d0ba0521ca0b17816f059ec9636e916de96ca5cfa1940dce"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.60/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "babf013db2143c66b073426fa7e94403c125ee5d42d3f89335056a7b226ba10c"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.60/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "678863d054aa44e49209c186819f17c7427579f765775ed43da6604d39a7498e"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.60/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6084e01d1e83d704dbe496691d69cd293513950cd782d90394c0760e7a58660b"
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
