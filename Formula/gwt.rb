class Gwt < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwt"
  version "1.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.4.1/gwt-v1.4.1-aarch64-apple-darwin.tar.gz"
      sha256 "e1524ae1db461baadc81329dfeba70266973365533394cc61daeabcb445a6fd0"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.4.1/gwt-v1.4.1-x86_64-apple-darwin.tar.gz"
      sha256 "7b5bee75d7e697470062d8044099aa895a46c0e455a6399d6737daeb0a210ed2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.4.1/gwt-v1.4.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d1e50d13bcedf1ab0fcf3af65f5c864d243ea34c8872fdb8bd022e8d2647ff13"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.4.1/gwt-v1.4.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e8a4ecb10e06e38b3e0892c527aa2de51a5d3ff9cfef3bccf306b67a6d0b7986"
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
