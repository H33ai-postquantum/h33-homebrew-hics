# Homebrew formula for h33-mcp — H33 Model Context Protocol server (Rust)
#
# Install: brew install h33/tap/h33-mcp
# Usage:   h33-mcp        (talks JSON-RPC over stdio)
#
# The canonical Model Context Protocol surface for the H33 post-quantum
# substrate, FHE biometric auth, ZK-STARK proofs, triple-key signing,
# BotShield, HICS, HATS, and Bitcoin UTXO quantum insurance. Native Rust.
# Refuses to start if handed a server-side ck_live_* key by mistake.

class H33Mcp < Formula
  desc "H33 Model Context Protocol server — post-quantum substrate for AI agents"
  homepage "https://mcp.h33.ai"
  version "0.1.0"
  license "Proprietary"

  if OS.mac? && Hardware::CPU.arm?
    url "https://install.h33.ai/h33-mcp-#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "PLACEHOLDER_SHA256_DARWIN_ARM"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://install.h33.ai/h33-mcp-#{version}-x86_64-apple-darwin.tar.gz"
    sha256 "PLACEHOLDER_SHA256_DARWIN_X86"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://install.h33.ai/h33-mcp-#{version}-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "PLACEHOLDER_SHA256_LINUX_ARM"
  elsif OS.linux?
    url "https://install.h33.ai/h33-mcp-#{version}-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "PLACEHOLDER_SHA256_LINUX_X86"
  end

  def install
    bin.install "h33-mcp"
  end

  def caveats
    <<~EOS
      h33-mcp needs a cka_* agent capability token to start.

      Mint one with the h33 CLI:
        brew install h33/tap/h33-cli
        h33 mint
        export H33_AGENT_TOKEN="cka_..."

      Or add to ~/.claude/mcp.json:
        {
          "mcpServers": {
            "h33": {
              "command": "h33-mcp",
              "env": { "H33_AGENT_TOKEN": "cka_..." }
            }
          }
        }

      The server will REFUSE TO START if H33_AGENT_TOKEN looks like a
      ck_live_* server key. This is intentional — agents must hold cka_*,
      servers hold ck_live_*, and they are never the same thing.
    EOS
  end

  test do
    # h33-mcp prints its version on --version, no token required.
    assert_match version.to_s, shell_output("#{bin}/h33-mcp --version")
  end
end
