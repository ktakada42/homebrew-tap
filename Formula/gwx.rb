class Gwx < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwx"
  version "2.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwx/releases/download/v2.1.0/gwx-v2.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "8ec83cc54097ba61e85716741170aea4cf29a9912c80a2c39cb742b7861a77fe"
    else
      url "https://github.com/ktakada42/gwx/releases/download/v2.1.0/gwx-v2.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "4f4263086d30a1de83db3cafa672b56f341595885109c57183d7cc2cdbcef5d4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwx/releases/download/v2.1.0/gwx-v2.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ac0715a9e1570a1e291fac36204057306dd60ae00eb4c93df85e2392693ea50d"
    else
      url "https://github.com/ktakada42/gwx/releases/download/v2.1.0/gwx-v2.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "88eaa457fd28c2e72b562ae3c7a58eb5fd6e541afd3cb6d3c7f3c08580860e5d"
    end
  end

  def install
    bin.install "gwx"
    generate_completions_from_executable(bin/"gwx", "completion")
    system bin/"gwx", "man", "--out-dir", buildpath/"man"
    man1.install Dir[buildpath/"man/*.1"]
  end

  def caveats
    <<~EOS
      `gwx cd` needs a shell function to change the directory of your shell.
      Add one of these to your shell config:

        bash:  eval "$(gwx shell-init bash)"
        zsh:   eval "$(gwx shell-init zsh)"
        fish:  gwx shell-init fish | source
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gwx --version")
    assert_match "COMPLETE", shell_output("#{bin}/gwx completion zsh")
  end
end
