class Gwx < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwx"
  version "2.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwx/releases/download/v2.4.0/gwx-v2.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "610517861c8e702f06deb1562954800d4c6aa8eea5710cc248551e8761beabfe"
    else
      url "https://github.com/ktakada42/gwx/releases/download/v2.4.0/gwx-v2.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "6eca7b936567ecd25f0ab4df650dc8079767c4cececd8148be70e353db1ac95a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwx/releases/download/v2.4.0/gwx-v2.4.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f6c802e45770dcb0de2a8bd8a0bbf33f027c6c0ef9b8a916d836c7db8bb1140f"
    else
      url "https://github.com/ktakada42/gwx/releases/download/v2.4.0/gwx-v2.4.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "167b8bf31aea4c12ec5153c49751520a0a12d9b23a61d5276a1f31aec2e8b903"
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
