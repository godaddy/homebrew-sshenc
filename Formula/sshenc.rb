class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/jgowdy/sshenc"
  version "0.5.1"
  license "MIT"

  on_arm do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.5.1/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "079a4f1e14c1aa6553af4ef53144fe1fac007b6516923b67eff8a69d96bb9009"
  end

  on_intel do
    url "https://github.com/jgowdy/sshenc/releases/download/v0.5.1/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "3eb464a884c1be1ecefd30b969f11e9ac7fda4c2b8de8454b0edc0d69d84a5df"
  end

  depends_on :macos

  def install
    bin.install "sshenc"
    bin.install "sshenc-keygen"
    bin.install "sshenc-agent"
    bin.install "gitenc"
    lib.install "libsshenc_pkcs11.dylib"    end

  test do
    assert_match "sshenc", shell_output("\#{bin}/sshenc --help 2>&1", 2)
  end
end
