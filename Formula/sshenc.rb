class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.39"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.39/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "cb1510b6a8effbc09e88b5db3a600726ae2d82149b15d394412697f83c4dd3cd"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.39/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "ddcc1b1292132f0e2561a6f8f6fede82dcfea95d2dc31910279ef5e908c4e57d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.39/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2aaeed89ddca97a7fb36567d96c591400270d745a5c5f08ce8022c0b43eb807f"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.39/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eb3e78bdf4ba80534d01f46c1309cbc845a892ddce8ee82a7bd7062c1a37490f"
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
