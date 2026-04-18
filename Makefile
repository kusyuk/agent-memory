PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

.PHONY: install uninstall

install:
	@echo "Installing agent-memory to $(BINDIR)..."
	mkdir -p $(BINDIR)
	cp bin/agent-memory $(BINDIR)/agent-memory
	chmod +x $(BINDIR)/agent-memory
	@echo "Installation complete. Try running 'agent-memory status'"

uninstall:
	@echo "Removing agent-memory from $(BINDIR)..."
	rm -f $(BINDIR)/agent-memory
	@echo "Uninstalled."
