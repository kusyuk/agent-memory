class AgentMemory < Formula
  desc "Cross-agent memory system for AI collaborators"
  homepage "https://github.com/kusyuk/agent-memory"
  url "https://github.com/kusyuk/agent-memory/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000" # TODO: Update after release
  license "MIT"

  def install
    bin.install "bin/agent-memory" => "agent-memory"
  end

  test do
    system "#{bin}/agent-memory", "help"
  end
end
