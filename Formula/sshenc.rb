class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.77"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.77/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "049a12786628952db39d3135b9748a5fee5547340752fa2a176e4a2a1c28b782"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.77/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "c5049af46b1d87d101ee517acd0038a422f9bdecb46e910ac5216b922f930406"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.77/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "788d138fb13c259ae3d235806989df2219d12b81561488e9031a6149e9af09ea"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.77/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c6604c8bb82b0f1d1da4c3cd433ea60c663fecf32aeeff0f130fcdfccfcbf078"
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
