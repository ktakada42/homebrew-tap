class Forge < Formula
  desc "Interactive CLI REPL for encoding, decoding, and conversion tasks"
  homepage "https://github.com/ktakada42/dev-forge"
  version "1.0.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/dev-forge/releases/download/v1.0.1/forge-v1.0.1-aarch64-apple-darwin.tar.gz"
      sha256 "015216416de1b36a84dd417fa02543d3a1dd4df4fb764a02add37f0d66ce1a87"
    else
      url "https://github.com/ktakada42/dev-forge/releases/download/v1.0.1/forge-v1.0.1-x86_64-apple-darwin.tar.gz"
      sha256 "d5673299a361c08c7841a6a519a67afa9c52ea426da4fe783f4da53831851317"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/dev-forge/releases/download/v1.0.1/forge-v1.0.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "41c25d5c871b5e757e6ea9b21a89a9a3135156817f949aed3f3b8ab9c122aea3"
    else
      url "https://github.com/ktakada42/dev-forge/releases/download/v1.0.1/forge-v1.0.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6acafdcaf7408f5998e92284f4982801ed8179d845fe39d546dc496579c45761"
    end
  end

  def install
    bin.install "forge"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/forge --version")
  end
end
