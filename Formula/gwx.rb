class Gwx < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwx"
  version "2.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwx/releases/download/v2.2.0/gwx-v2.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "d2d745dcdb72bc7fcb0b6f144430de736e2b6dcb760219e8855ec64cf84cee66"
    else
      url "https://github.com/ktakada42/gwx/releases/download/v2.2.0/gwx-v2.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "f90b296788e05141e1eab1360b0309e38d9a985faa5aa01774ee835792bf1708"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwx/releases/download/v2.2.0/gwx-v2.2.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "bf5f32b1914e8acebd10a5731c39f6c12428a7c323814fce94eaaf7e72ec30a4"
    else
      url "https://github.com/ktakada42/gwx/releases/download/v2.2.0/gwx-v2.2.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "508e764bd3130d2298e5687fd2af97292f34b8a82cba563f72fe61c44240bc00"
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
