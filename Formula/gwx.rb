class Gwx < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwx"
  version "2.2.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwx/releases/download/v2.2.2/gwx-v2.2.2-aarch64-apple-darwin.tar.gz"
      sha256 "22bf978b54a426631eec722d91fa90dd9448389896b96146101361d40ba47079"
    else
      url "https://github.com/ktakada42/gwx/releases/download/v2.2.2/gwx-v2.2.2-x86_64-apple-darwin.tar.gz"
      sha256 "2c6f8820eeef35f3ba95dd81c0a8ec19d81d2893ece3f2c0c56bf2fa8ebf6cab"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwx/releases/download/v2.2.2/gwx-v2.2.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8d39659bcddad2426bcf56fabdf27364551ed33c2f78f7912ea363e4e31822c0"
    else
      url "https://github.com/ktakada42/gwx/releases/download/v2.2.2/gwx-v2.2.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "eabafe712cb2f5e39572958fab3f9c88e656d9d803b98a1f08932f5e5ad170d4"
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
