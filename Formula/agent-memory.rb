class AgentMemory < Formula
  desc "Cross-agent memory system for AI collaborators"
  homepage "https://github.com/kusyuk/agent-memory"
  url "https://github.com/kusyuk/agent-memory/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "bf843d9093e80b99c8bf388e8afa801bb2d7170a8179dd4fd632131878fb0c3b"
  license "MIT"

  def install
    bin.install "bin/agent-memory" => "agent-memory"
  end

  test do
    system "#{bin}/agent-memory", "help"
  end
end
