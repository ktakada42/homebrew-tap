class Gwx < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwx"
  version "2.0.0"
  license "MIT"

  # gwx was called gwt up to v1.4.1. This migrates an installed gwt
  # on `brew upgrade` rather than leaving it frozen at the old name.
  oldnames "gwt"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwx/releases/download/v2.0.0/gwx-v2.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "1829522d5b377908616dc337e43cf83e9ac63c838481093f780312ffea69121e"
    else
      url "https://github.com/ktakada42/gwx/releases/download/v2.0.0/gwx-v2.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "45e739999cf9a9bdf65cfe4537d4b2c8bd5772df9d2251b3efaaa4ba573c5982"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwx/releases/download/v2.0.0/gwx-v2.0.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9839115f923db006eb13c1d30f7250804503a5fb3be8d5271c3a481e3dbbfd77"
    else
      url "https://github.com/ktakada42/gwx/releases/download/v2.0.0/gwx-v2.0.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d427cfec8c2e8bbd69941a5dfa85a1d7dd735a8ca7bbcafce3f4de96c1832d80"
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
