class Gwt < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwt"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.0.0/gwt-v1.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "14a60bc859e629355e351f0ad10420eb55363ecd9a351c40141aeed04c8addc9"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.0.0/gwt-v1.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "77854e0b695a189fd92bc9c0a4f2256f80fef4ab936ad6969f2e0904a99fbc6c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.0.0/gwt-v1.0.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0bbd51be89d2fd731bce22259d1267f9153eba76b51ba86933fb4797a2913a61"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.0.0/gwt-v1.0.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b8cffeae78bf5b37edbb2b2af333e821f52a897ff0c61fcdd14f02aff9b7cc02"
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
