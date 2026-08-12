class Gwt < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwt"
  version "1.3.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.3/gwt-v1.3.3-aarch64-apple-darwin.tar.gz"
      sha256 "fe5366ad5950357397136e0df93b2de7d9438851762e779fa5ee0ffaef11d089"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.3/gwt-v1.3.3-x86_64-apple-darwin.tar.gz"
      sha256 "af3269142ffced6209ae01fd86915ea950a6018f35efcddba1b735ec3d040604"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.3/gwt-v1.3.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8c68e8a79b078651d60ede339fd6bd60eea3cb4f320c8fff4faa23ceb688b5de"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.3/gwt-v1.3.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "956c4e38373d2378da17cdab6a18e7c044ff53a74ed13f4522a37add75142f6d"
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
