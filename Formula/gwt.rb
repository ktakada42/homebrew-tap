class Gwt < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwt"
  version "1.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.4.0/gwt-v1.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "c2d44a64e811059977c6f0526a93450280a4716fafec51f71c77a2330a057011"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.4.0/gwt-v1.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "252e7a666cd7ca3b7ce2e25f4f865fb9b5556fff57c47d8ea94287cd380f9529"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.4.0/gwt-v1.4.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "34366597f547acdecc64198a815558163c3c96902fca0f3e3f4d51cf9ac2f824"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.4.0/gwt-v1.4.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9ee2abf5af1e40d6d348e03c837b0db99d884ff5a9052ac1fe3ebc54ab1dfbe1"
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
