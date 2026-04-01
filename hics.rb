# Homebrew formula for HICS — H33 Independent Code Scoring
#
# Install: brew install h33/tap/hics
# Usage:   hics scan .
#
# Free. Local. No account. No network calls.
# The algorithm is the authority.

class Hics < Formula
  desc "H33 Independent Code Scoring — trustless software quality assessment"
  homepage "https://h33.ai/hics"
  version "0.1.0"
  license "BUSL-1.1"

  # Binary releases hosted on GitLab
  # Replace with actual release URLs after first build
  if OS.mac? && Hardware::CPU.arm?
    url "https://gitlab.com/h33-ai/hics-releases/-/raw/main/hics-0.1.0-aarch64-apple-darwin.tar.gz"
    sha256 "3a762446ccd7ee84c8e0f6183e65c4030c0677c85751a048d8fa849e08302f91"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://gitlab.com/h33-ai/hics-releases/-/raw/main/hics-0.1.0-x86_64-apple-darwin.tar.gz"
    sha256 "PLACEHOLDER_SHA256_X86"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://gitlab.com/h33-ai/hics-releases/-/raw/main/hics-0.1.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "PLACEHOLDER_SHA256_LINUX_ARM"
  elsif OS.linux?
    url "https://gitlab.com/h33-ai/hics-releases/-/raw/main/hics-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "PLACEHOLDER_SHA256_LINUX_X86"
  end

  def install
    bin.install "hics"
  end

  test do
    assert_match "H33 Independent Code Scoring", shell_output("#{bin}/hics version")
    assert_match "Algorithm version: 1.0.0", shell_output("#{bin}/hics version")
  end
end
