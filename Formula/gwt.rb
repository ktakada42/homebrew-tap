class Gwt < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwt"
  version "1.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.1.0/gwt-v1.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "51ae709ea97bd213fa63557a66a9f8dd4100eb7e687b09f5f7160e17c0300e7d"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.1.0/gwt-v1.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "a087e355fc7022d75e880f57d91b59d868f6aa12d46b2737e06531d33696147a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.1.0/gwt-v1.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "cf8b418bfd4a857f0b2a53d16ae7b7f8148b1e5a42a85a777a7320a8c0476a6b"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.1.0/gwt-v1.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9de90ff8bcc79a05f29ac2afb785f735def8b7e4adbc17b3e791f07165a9c26d"
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
