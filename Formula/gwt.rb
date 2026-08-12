class Gwt < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwt"
  version "1.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.1/gwt-v1.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "17e146c81f8fa427c356821cabbafd3ef2aa8ff5b284916a1816f546fca06eee"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.1/gwt-v1.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "da2111d9a35d8ce8994190fe8468ab1b13b4aeb9a31ebdab15f8f01949e66adb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.1/gwt-v1.3.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a5beb6a1824d8e5a80b8064482233cddda514efeb05b719398c8681273732248"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.1/gwt-v1.3.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e09545ae85ddda544ba3c142d7066d2e2cd5dd96f5d21de66d022d91d78ffa08"
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
