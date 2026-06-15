class Forge < Formula
  desc "Interactive CLI REPL for encoding, decoding, and conversion tasks"
  homepage "https://github.com/ktakada42/dev-forge"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/dev-forge/releases/download/v0.1.0/forge-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "82ccde36f07df3524eac18031dcb05db2ecd0d7fcd11c581acd40a8b6be2db65"
    else
      url "https://github.com/ktakada42/dev-forge/releases/download/v0.1.0/forge-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "663354d75008eb9b2373db2e6e4383446e0d1abd9291ea1c5921ddeec6d84d96"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/dev-forge/releases/download/v0.1.0/forge-v0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "97fae506e05ccf1cbad907f0ec149a856eb92bcc19440ed2ce5c33685d517298"
    else
      url "https://github.com/ktakada42/dev-forge/releases/download/v0.1.0/forge-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "174a00825306006210d5d02fb87f7250aed799401149bc9768ef97f2b9c4440c"
    end
  end

  def install
    bin.install "forge"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/forge --version")
  end
end
