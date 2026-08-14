class Gwx < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwx"
  version "2.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwx/releases/download/v2.2.1/gwx-v2.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "8ff9c3d891e45e16a5efb12c4f24269d4e3ea9949b09e28aee8a8297b94c42aa"
    else
      url "https://github.com/ktakada42/gwx/releases/download/v2.2.1/gwx-v2.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "a7c1e3faace8ce278fbe9b869c775b41e83efb9ed7842c94b9114201aebc6b77"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwx/releases/download/v2.2.1/gwx-v2.2.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4e51aadd6ec5ac92845e0c65f14e52730a376ccb5991ed35a19bd2951727dc0b"
    else
      url "https://github.com/ktakada42/gwx/releases/download/v2.2.1/gwx-v2.2.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b8ef43392b1f22fe8fb45ff966b86f7cfccfc927ce4a98e4978c634ce51ba7cd"
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
