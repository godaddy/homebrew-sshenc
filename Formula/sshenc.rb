class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.35"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.35/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "f0e50446015da58c6bc6a8d28aed2b6d6f41d9f185fb0f016d414490c057cf07"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.35/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "bbd07916e2d47a4864f733a7762c9dbb89dba634dde324b79c3d086de9742efd"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.35/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "66b98287fdb40d1d6f8c2ba16c65898f66c1026f9155b78607422e51e19c52d7"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.35/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9d1390cfbd84fe2b6ed7d48839867c781ed4228677423b7375259ba53698c4d1"
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
