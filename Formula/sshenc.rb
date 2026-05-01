class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.42"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.42/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "653946f8e843e9c0094c409f0eae5382e9b9f803ca537a7b5f04918b83d1a905"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.42/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "633e9cb87a3c58fc4f4b0cfed1e35bb4c6ed2caef996d873e8b54a974a075dbd"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.42/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d9bff292099f542cfbf6c386dfd78e132ae08297a619928c0aef35c163f51615"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.42/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6fe99cf889f94dd9e339b695cee208d76aa9f3e70183d737da5029263efa15f0"
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
