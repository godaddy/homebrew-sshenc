class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.19"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.19/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "252f7443c1d0acad8a501b492ebcbfb1d5500bd9fab9c717b86ed3336fc77c43"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.19/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "8660de832e191acb8ba77a6aff11ed8020ae69ebd535c473dc7abf2676696092"
  end

  depends_on :macos

  def install
    bin.install "sshenc"
    bin.install "sshenc-keygen"
    bin.install "sshenc-agent"
    bin.install "gitenc"
    bin.install "sshenc-tpm-bridge"
    lib.install "libsshenc_pkcs11.dylib"    end

  test do
    assert_match "sshenc", shell_output("\#{bin}/sshenc --help 2>&1", 2)
  end
end
