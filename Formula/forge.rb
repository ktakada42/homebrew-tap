class Forge < Formula
  desc "Interactive CLI REPL for encoding, decoding, and conversion tasks"
  homepage "https://github.com/ktakada42/dev-forge"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/dev-forge/releases/download/v0.1.0/forge-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "ede0439b41e305be91608202c15da60bb0c1e8e2b2ee4ff6cb1c5c438d6115c1"
    else
      url "https://github.com/ktakada42/dev-forge/releases/download/v0.1.0/forge-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "553003525bcc5befff6b0675cd083c4fb7b7708cae97026f1f945b870799e495"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/dev-forge/releases/download/v0.1.0/forge-v0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e519a4fa5f34eb6574f76cd4f51b16181a7b3b5ed5e1c22dcf71f6e4190293c7"
    else
      url "https://github.com/ktakada42/dev-forge/releases/download/v0.1.0/forge-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "976de6e27ca1b7ae7e43492a16855d6f36479851f2b8a7f9aeb4f409da18a63b"
    end
  end

  def install
    bin.install "forge"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/forge --version")
  end
end
