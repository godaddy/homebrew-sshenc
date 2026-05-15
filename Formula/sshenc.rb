class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.90"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.90/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "7d73aa6a626f15669e99a459e77329c2e34de610d8d7118b3fe393ff745e024c"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.90/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "febbac8b918b81d3ebc0c535f45c4d972778ca346d5545574a78d651733636a0"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.90/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "96160f1d8a0cec4917e615c1fb0cc274935607537ebae22ecc0de5b3b3a925ba"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.90/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f54fff78f2f787fd45601b9557a4c4d5a0ff0d397ae995c4dbb98ae4ad327e03"
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

  def post_install
    # Restart a running LaunchAgent-managed daemon so users pick up the
    # new binary immediately after .  kills
    # and relaunches the service; with KeepAlive=true launchd always
    # restarts it. Explicitly targets the gui/<uid> bootstrap domain so
    # this works when brew runs in a background auto-updater context
    # (which lacks the default user session domain that plain
    #  targets). No-op if the LaunchAgent has not been
    # installed yet.
    plist = "#{Dir.home}/Library/LaunchAgents/com.godaddy.#{name}.agent.plist"
    if File.exist?(plist)
      uid = Process.uid.to_s
      system "launchctl", "kickstart", "-k", "gui/#{uid}/com.godaddy.#{name}.agent"
    end
  end

  def uninstall
    # Run the app's own uninstall command before Homebrew removes the
    # binary. This cleans up the SSH config block, shell rc snippet,
    # and LaunchAgent plist so a broken agent job isn't left pointing
    # at a deleted binary after . Idempotent: safe to
    # call even if the app was never configured.
    quiet_system "#{bin}/#{name}", "uninstall"
  end

  def caveats
    <<~EOS
      After installing, run:
        #{name} install

      This configures SSH to use #{name} and starts the agent.

      Before uninstalling with , run:
        #{name} uninstall

      Or simply run  — the formula's uninstall
      hook calls  automatically while the binary is
      still present.
    EOS
  end

  test do
    assert_match "sshenc", shell_output("#{bin}/sshenc --help 2>&1", 2)
  end
end
