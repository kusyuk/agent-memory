class AgentMemory < Formula
  desc "Cross-agent memory system for AI collaborators"
  homepage "https://github.com/kusyuk/agent-memory"
  url "https://github.com/kusyuk/agent-memory/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  license "MIT"

  def install
    bin.install "bin/agent-memory" => "agent-memory"
  end

  test do
    system "#{bin}/agent-memory", "help"
  end
end
