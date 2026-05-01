class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.37"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.37/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "cc0f52526c2b32b609744fdead8548a3858936ecf8de48daec8bf9067a341db3"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.37/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "8b17e8891421214864a3616952cf3e0ae22b7fce582de4d166a22039ab3bb49c"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.37/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "225d89a32ae0f91f3cb25afb12f19248bf40f64e5915f6be95d42d263525a24d"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.37/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "19606082854af0f0a2a2b4268e2efea3c83c4c4b5d7d49e6dc8e45eb2164b2bc"
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
