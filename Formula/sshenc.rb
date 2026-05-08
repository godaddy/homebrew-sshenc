class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.68"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.68/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "eeaae71113e95b4a2e123756b6eefd435768e29d1f478fc93bbcd7636274c6ed"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.68/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "94ebe2f0d2328b67e6fcace35037f84ffa6d45878f64e8dc4bcbdae2a95f32d4"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.68/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "59b141dda518f111bcb607fb5ff4268f25659c9903ebdf755188944e29e612ac"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.68/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dee69c70c716f87fbc599a239277260e31f44e795357a018a8476bf41444eaeb"
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
