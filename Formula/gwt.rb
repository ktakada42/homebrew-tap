class Gwt < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwt"
  version "1.3.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.4/gwt-v1.3.4-aarch64-apple-darwin.tar.gz"
      sha256 "f8b37dc18f23bc5c811e994a4d82344bdae044187a6d355f41825ddd22436f82"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.4/gwt-v1.3.4-x86_64-apple-darwin.tar.gz"
      sha256 "438c54a8a24874b7915a4c7884bfc9b7dc83a50d52d6310d8f34bdd0a6f8f62a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.4/gwt-v1.3.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "62f943192c90b71c38f7ec9aa359f1e29e62ad2a7cd70a81c3242cc97ca74931"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.4/gwt-v1.3.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3562b7c1336ca6b32ebfe49acf6f63ff4e30ac181b830261f1ec0e576913df3b"
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
