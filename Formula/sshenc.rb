class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.62"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.62/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "389c28c3ffa8272dfa0ae69ef479080637f006320e378854301f28b71cc12c16"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.62/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "063012d5edb968eec7fca552163745d828f8dce6057087b49d1f26b7ac935ef9"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.62/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6854cc517f823e36ac791f67aa7a6d9bad747a8b26107c62db8260cf02f0f722"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.62/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4378dc5a409c8d1f78bd0ddbf49d0db970d14c59302add391e2538b362564e20"
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
