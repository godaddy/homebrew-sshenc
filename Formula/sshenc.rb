class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.45"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.45/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "22170dd10cb1bb669fdd42c683be722bc96cd93bac4298e39f402f926ae95e83"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.45/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "c05371193bb075cb8ba313351829846b06df2bef2d96333c72f67a19a2337465"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.45/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f2f3dd176a5a2171fbe211c573b143136d25fdc5cc390a8c2f5ef2abc107f5cf"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.45/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0c3e4d5f800a81ef254f0754361a54ec33c7ddaee9d19813b296e625436c0a4a"
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
