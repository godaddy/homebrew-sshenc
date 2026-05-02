class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.50"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.50/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "afaf860df7a5932dd70e01c0af08acd9735a8f93708a4cc61f731944c4203cb8"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.50/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "5a9c66fc53b6b286282a921a5f00bee20453c70b1fb9183a7860a22d247bf417"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.50/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f6bece47cc6c5755e08305f61315348bbf43649e5fb4c8740a25ff4392413b6f"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.50/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a6ffaef58d5dea04f0da488344c8a7ed835bf2403d1d8c771f5e0800aa5c46a7"
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
