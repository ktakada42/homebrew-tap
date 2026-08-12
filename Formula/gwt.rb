class Gwt < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwt"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v0.1.0/gwt-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "646c3b2bf1b4162d335c5b21a0839d315229db2b7c276d0b275a0629a37cd43e"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v0.1.0/gwt-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "c8fd0002d79e4601511630cab5a7c44f44a8f0c44b633bfd88bb59cf1c88ee9f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v0.1.0/gwt-v0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2e4d0e8ac1c37ff2854ba76802ce82f2132b99ca28f108f4b3ec672fd6d8c188"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v0.1.0/gwt-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b49b4eb2ac03fcfe8e9632164e419d3f2f7aa6cf92e426561e1f8bd1909a3e34"
    end
  end

  def install
    bin.install "gwt"
    generate_completions_from_executable(bin/"gwt", "completion")
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
