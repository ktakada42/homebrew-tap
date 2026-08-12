class Gwt < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwt"
  version "1.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.0/gwt-v1.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "9a7a414779ce1c40a156948dd05471795350ff6402fa41d4bf11592480dc1ad0"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.0/gwt-v1.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "0c7f83afaf3f19aaf9d64cd202224fd74fa10c2bf776be5b519995fe74e0743b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.0/gwt-v1.3.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "dcb27a8c46eb31b6118f38c1a9797637911e916d92336ec0f341832023aab6bc"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.0/gwt-v1.3.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "73ed9581cacf1d7f5fc5f3658869041adc864a7c730d05f511681c5df47e5e51"
    end
  end

  def install
    bin.install "gwt"
    generate_completions_from_executable(bin/"gwt", "completion")
    system bin/"gwt", "man", "--out-dir", buildpath/"man"
    man1.install Dir[buildpath/"man/*.1"]
  end

  def caveats
    <<~EOS
      `gwt cd` needs a shell function to change the directory of your shell.
      Add one of these to your shell config:

        bash:  eval "$(gwt shell-init bash)"
        zsh:   eval "$(gwt shell-init zsh)"
        fish:  gwt shell-init fish | source
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gwt --version")
    assert_match "COMPLETE", shell_output("#{bin}/gwt completion zsh")
  end
end
