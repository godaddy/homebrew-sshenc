class Sshenc < Formula
  desc "Hardware-backed SSH key management"
  homepage "https://github.com/godaddy/sshenc"
  version "0.6.89"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.89/sshenc-aarch64-apple-darwin.tar.gz"
      sha256 "8716c727bb57a93c21eaa7b09047a7eeab68f205bc704ddebd73508fbc07228d"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.89/sshenc-x86_64-apple-darwin.tar.gz"
      sha256 "88b00e836fe83f15f8bd01b20338741c866a97e51cf42020bfde45921c2535ef"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.89/sshenc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a3b3100801b9aff85bcdc6591f7e43558c01d9869638c77024cb3d32607db769"
    end

    on_intel do
      url "https://github.com/godaddy/sshenc/releases/download/v0.6.89/sshenc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e7773cdb95f7927c05b63f616c3c7a4441387e468ff3c549d127e345bf7fcad9"
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
