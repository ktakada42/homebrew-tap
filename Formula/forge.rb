class Forge < Formula
  desc "Interactive CLI REPL for encoding, decoding, and conversion tasks"
  homepage "https://github.com/ktakada42/dev-forge"
  version "1.0.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/dev-forge/releases/download/v1.0.2/forge-v1.0.2-aarch64-apple-darwin.tar.gz"
      sha256 "f50956b0badc476d6b301b0fa2f0e0e018b085f36169a13626c2c0badbec4983"
    else
      url "https://github.com/ktakada42/dev-forge/releases/download/v1.0.2/forge-v1.0.2-x86_64-apple-darwin.tar.gz"
      sha256 "63a2e181fd269273066acea160be98b9b7cac09bb2fc79c7a6c9c98bf188cb67"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/dev-forge/releases/download/v1.0.2/forge-v1.0.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "50e33b76645e0e582387577b720e58eb43ad2da9786a74b48383a5f60f0a32dc"
    else
      url "https://github.com/ktakada42/dev-forge/releases/download/v1.0.2/forge-v1.0.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "62f67bb2e75dd7cc44f7c64e56d3213a06a02c8a601486ce4e16378a9b051d53"
    end
  end

  def install
    bin.install "forge"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/forge --version")
  end
end
