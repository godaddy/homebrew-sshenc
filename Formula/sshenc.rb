class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.28"
  license "MIT"

  on_arm do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.28/sshenc-aarch64-apple-darwin.tar.gz"
    sha256 "4faf06fa7be1fe25fcfb814373507eac06531d16dba84960dab4b4c846dbf357"
  end

  on_intel do
    url "https://github.com/godaddy/sshenc/releases/download/v0.6.28/sshenc-x86_64-apple-darwin.tar.gz"
    sha256 "630653a70fe382950d09e7aa74578721d76422bff855a697e2764f0bf5a272b0"
  end

  depends_on :macos

  def install
    prefix.install "sshenc.app"
    bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc" => "sshenc"
    bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc-keygen" => "sshenc-keygen"
    bin.install_symlink prefix/"sshenc.app/Contents/MacOS/sshenc-agent" => "sshenc-agent"
    bin.install_symlink prefix/"sshenc.app/Contents/MacOS/gitenc" => "gitenc"    end

  test do
    assert_match "sshenc", shell_output("\#{bin}/sshenc --help 2>&1", 2)
  end
end
