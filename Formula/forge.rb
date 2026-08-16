class Forge < Formula
  desc "Interactive CLI REPL for encoding, decoding, and conversion tasks"
  homepage "https://github.com/ktakada42/dev-forge"
  version "2.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/dev-forge/releases/download/v2.0.0/forge-v2.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "d4a487e326c6b48098972b246a24f0589bf6aa7f35183d9a8fff9d12b7e8cca5"
    else
      url "https://github.com/ktakada42/dev-forge/releases/download/v2.0.0/forge-v2.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "b1d1e4c215931c30270901c590e81e6c5df02d7da65d3520b8515d587b6d35c6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/dev-forge/releases/download/v2.0.0/forge-v2.0.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f20ef75ab4dd29921fd4b02dddcb277f11a2a877b8d267edf0d0cbb0733493e8"
    else
      url "https://github.com/ktakada42/dev-forge/releases/download/v2.0.0/forge-v2.0.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "eae3aa8b74056d5fc31339e8c938fa4b695e93265464923532a18054ab4e08cc"
    end
  end

  def install
    bin.install "forge"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/forge --version")
  end
end
