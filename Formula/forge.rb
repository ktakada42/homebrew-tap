class Forge < Formula
  desc "Interactive CLI REPL for encoding, decoding, and conversion tasks"
  homepage "https://github.com/ktakada42/dev-forge"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/dev-forge/releases/download/v1.0.0/forge-v1.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "a270e81d9aab3bd417109095db79517d75b26224b4f36ad6b4373909c4aaf661"
    else
      url "https://github.com/ktakada42/dev-forge/releases/download/v1.0.0/forge-v1.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "cb09c68b927bd2446cf5f57d36887ebcf96d8f9dbe55a47847b9dfb40610ae1f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/dev-forge/releases/download/v1.0.0/forge-v1.0.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "52a6d3bbc19e9de7643d306eeaf5b950ab79a8cbadb20ddc842b102a7e4169aa"
    else
      url "https://github.com/ktakada42/dev-forge/releases/download/v1.0.0/forge-v1.0.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "06f002f794a879d86da55f0ec00392cae39d14c657c173ce1ffd34d945f89726"
    end
  end

  def install
    bin.install "forge"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/forge --version")
  end
end
