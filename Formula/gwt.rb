class Gwt < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwt"
  version "1.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.2.0/gwt-v1.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "e8ec691d630e9ca1c372720c2d01d15619f5b2c8fbc5ea1ddeb1dd81ad755b32"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.2.0/gwt-v1.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "2cb1789aef6e7d1231b2203746207b72691758b6a0ccaeeb564876e9dd43c413"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.2.0/gwt-v1.2.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "67cb02bf6f9ee57ebf8985d878c55030b7d6f763bf92a060c84e74ec22e7f9f0"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.2.0/gwt-v1.2.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "52b07c934d77cbb575ae6154f9f4785c1724dd99ece23182f7681d7d0900b9ff"
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
