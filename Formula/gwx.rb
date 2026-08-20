class Gwx < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwx"
  version "2.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwx/releases/download/v2.3.0/gwx-v2.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "b69e1146080ea2cd956c2746ab1c75b8d833e5f2c4b4aa208efa22a3ac2f12fc"
    else
      url "https://github.com/ktakada42/gwx/releases/download/v2.3.0/gwx-v2.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "61e9fe6cab9cb03040ed4fc40fa6a2df976d7dbf35ece26b780511ba1556a923"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwx/releases/download/v2.3.0/gwx-v2.3.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "918e39a0e7f82d3f22f13bf59ba33062e04b02049bd2a44b0c37579737bd8460"
    else
      url "https://github.com/ktakada42/gwx/releases/download/v2.3.0/gwx-v2.3.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5fd11215bd7922375e88aa64b2d6a2b5a2839182c85afea05a215b743abf78b0"
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
