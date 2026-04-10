# Homebrew formula for h33-cli — H33 terminal companion (Rust)
#
# Install: brew install h33/tap/h33-cli
# Usage:   h33 signup        sign up at h33.ai
#          h33 mint          mint a cka_* agent capability token
#          h33 mcp           run the H33 MCP server
#          h33 status        show your tenant + usage
#          h33 audit         tail your H33 audit log
#          h33 detect .      scan a codebase for classical / quantum-vulnerable crypto
#          h33 wrap <file>   wrap a payload with the H33 substrate
#          h33 verify <id>   verify a substrate attestation
#          h33 scan .        run an HICS scan against this directory
#          h33 bitcoin attest --utxo ...   attest a Bitcoin UTXO with three PQ families
#          h33 health        check the H33 API health endpoint
#
# Native Rust. No Node dependencies. Replaces the legacy TypeScript CLI.

class H33Cli < Formula
  desc "H33 terminal companion — substrate, biometric, ZK, Bitcoin UTXO, MCP"
  homepage "https://h33.ai/cli"
  version "0.1.0"
  license "Proprietary"

  if OS.mac? && Hardware::CPU.arm?
    url "https://install.h33.ai/h33-cli-#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "PLACEHOLDER_SHA256_DARWIN_ARM"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://install.h33.ai/h33-cli-#{version}-x86_64-apple-darwin.tar.gz"
    sha256 "PLACEHOLDER_SHA256_DARWIN_X86"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://install.h33.ai/h33-cli-#{version}-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "PLACEHOLDER_SHA256_LINUX_ARM"
  elsif OS.linux?
    url "https://install.h33.ai/h33-cli-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "PLACEHOLDER_SHA256_LINUX_X86"
  end

  def install
    bin.install "h33"
  end

  def caveats
    <<~EOS
      Get started:
        h33 signup           # Open the signup flow in your browser
        h33 mint             # Mint a cka_* agent token (after signup)
        h33 mcp              # Run the MCP server for Claude Code / Cursor

      Configuration is read from environment variables and/or a local .env:
        H33_API_KEY          # ck_test_* (sandbox) or ck_live_* (production)
        H33_AGENT_TOKEN      # cka_* (short-lived agent capability token)
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/h33 --version")
  end
end
