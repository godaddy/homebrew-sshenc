class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.81"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.81/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "d29da0f017ce46023b86a7d520863de3df8f4a7137d2786728457af3659f9fa7"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.81/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "4f4c1f834ed08802abdc6c09e4dbff26c757805e90f99becc65ad5a54e2e06da"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.81/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cae76cab9f216b364cb67104fc50ecf17c0d48039f4f4b2262ea0a14c776bd7d"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.81/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "426b22b21de267f5003522757daffe40ebdbb686dcab9200160c70b25cda6d88"
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
