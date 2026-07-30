class Forge < Formula
  desc "Interactive CLI REPL for encoding, decoding, and conversion tasks"
  homepage "https://github.com/ktakada42/dev-forge"
  version "1.0.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/dev-forge/releases/download/v1.0.3/forge-v1.0.3-aarch64-apple-darwin.tar.gz"
      sha256 "4d1c1a55c5b10b6525c491dbe44977ea806ef1794ec0995c0d9d5c3817334758"
    else
      url "https://github.com/ktakada42/dev-forge/releases/download/v1.0.3/forge-v1.0.3-x86_64-apple-darwin.tar.gz"
      sha256 "0427b3d779fb5c3cdb7fdfcec96b613aff3655e16801c66dcd263ad566f2de65"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ktakada42/dev-forge/releases/download/v1.0.3/forge-v1.0.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ab6b64573496e5f195b94b2daa40e0c645cbe92f4d5506dfbeecd30dbdbb8a25"
    else
      url "https://github.com/ktakada42/dev-forge/releases/download/v1.0.3/forge-v1.0.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "09650876cef79ccbc21fab34c7ca7186e4a06ab39cb3658db23b026fe3ba3a0f"
    end
  end

  def install
    bin.install "forge"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/forge --version")
  end
end
