class Gwt < Formula
  desc "Friendly git worktree manager with automatic paths, hooks and shell integration"
  homepage "https://github.com/ktakada42/gwt"
  version "1.3.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.2/gwt-v1.3.2-aarch64-apple-darwin.tar.gz"
      sha256 "164a1865a13e8bd2870e80a79d58f99e90f6515f6af45eb453df6983d47aec73"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.2/gwt-v1.3.2-x86_64-apple-darwin.tar.gz"
      sha256 "e1971c6de03a27f225cf2327caa6b96243b459387172ea188bf44fb9e7dded43"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.2/gwt-v1.3.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6512a4bb8ed175656dc94ae86e2ed09d53f974adab624e27c0e45e2acb618463"
    else
      url "https://github.com/ktakada42/gwt/releases/download/v1.3.2/gwt-v1.3.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "99f942a448fe10f8a29fd04d46092463b3a5412fe95b6128697729c380e5336d"
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
