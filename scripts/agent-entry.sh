#!/bin/bash
# Agent entry hook - read memory and prepare context

echo "=== Memory State ==="
echo ""

echo "## Context:"
cat .memory/context.md | grep -A 100 "## Current State" | head -20

echo ""
echo "## Tasks:"
cat .memory/tasks.md | grep -A 100 "## In Progress" | head -10

echo ""
echo "## Last Snapshot:"
cat .memory/snapshot.md | grep -A 50 "## Last Agent" | head -15

echo ""
echo "=== Ready to work ==="
