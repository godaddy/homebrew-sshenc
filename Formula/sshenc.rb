class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.56"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.56/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "f9de8c15924a433714c25dac10faa2f3bfb5101c29b5128bc7125d33e441d792"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.56/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "1b3cb1aff481d76e24923258236dad1cf3337cd023199cc775f5b50b7b9e4236"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.56/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "68fe37c9cefb7ce6ee4b515cecf75bc4dff7b6bfc3116316905e9da627afdb53"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.56/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f249f36c7de29544e8df53f4c1aed9dc0a50a0fa2fa79956c9f90e9578540d8f"
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
