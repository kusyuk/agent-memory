#!/bin/bash
# tests/run_tests.sh: Functional test suite for agent-memory CLI

set -euo pipefail

# ANSI color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Setup temporary test environment
TEST_DIR=$(mktemp -d)
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
PROJECT_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
CLI="$PROJECT_ROOT/bin/agent-memory"

echo "Running tests in: $TEST_DIR"

cleanup() {
    rm -rf "$TEST_DIR"
    echo "Cleanup complete."
}
trap cleanup EXIT

# 🔹 Test 1: Initialization
echo -n "Test 1: 'init' command... "
cd "$TEST_DIR"
"$CLI" init > /dev/null
if [[ -d ".agent-memory" ]] && [[ -f ".agent-memory/context.md" ]]; then
    echo -e "${GREEN}PASSED${NC}"
else
    echo -e "${RED}FAILED${NC}"
    exit 1
fi

# 🔹 Test 2: Recursive Search
echo -n "Test 2: Recursive directory search... "
mkdir -p sub/dir/deep
cd sub/dir/deep
ACTUAL_MEM_DIR=$("$CLI" status | grep "Memory Directory:" | cut -d' ' -f3-) || true
if [[ "$ACTUAL_MEM_DIR" == *".agent-memory" ]]; then
    echo -e "${GREEN}PASSED${NC}"
else
    echo -e "${RED}FAILED${NC}"
    echo "  Expected something ending in: .agent-memory"
    echo "  Actual output: $ACTUAL_MEM_DIR"
    exit 1
fi

# 🔹 Test 3: Save and Resume
echo -n "Test 3: 'save' and 'resume' sequence... "
cd "$TEST_DIR"
TEST_COMPLETED="Finished feature A"
TEST_CURRENT="Working on feature B"
TEST_NEXT="Start feature C"

"$CLI" save "$TEST_COMPLETED" "$TEST_CURRENT" "$TEST_NEXT" > /dev/null

RESUME_OUTPUT=$("$CLI" resume)
if echo "$RESUME_OUTPUT" | grep -q "$TEST_COMPLETED" && \
   echo "$RESUME_OUTPUT" | grep -q "$TEST_CURRENT" && \
   echo "$RESUME_OUTPUT" | grep -q "$TEST_NEXT"; then
    echo -e "${GREEN}PASSED${NC}"
else
    echo -e "${RED}FAILED${NC}"
    exit 1
fi

# 🔹 Test 4: Makefile Installation
echo -n "Test 4: Makefile install syntax check... "
cd "$PROJECT_ROOT"
# Just check if make can parse the file and find the target without actually running it as sudo
if make -n install | grep -q "cp bin/agent-memory"; then
    echo -e "${GREEN}PASSED${NC}"
else
    echo -e "${RED}FAILED${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}All functional tests passed successfully!${NC}"
