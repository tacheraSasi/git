#!/bin/bash

# Git Status --json Feature Demonstration
# =======================================
# This script demonstrates the new --json flag for git status
# that provides structured JSON output for automation and tooling.

set -e

echo "=== Git Status --json Feature Demo ==="
echo ""

# Create a clean demo directory
DEMO_DIR="json-status-demo"
rm -rf "$DEMO_DIR"
mkdir "$DEMO_DIR"
cd "$DEMO_DIR"

echo "🔧 Setting up demo repository..."
../git init --quiet
../git config user.name "Demo User"
../git config user.email "demo@example.com"

echo ""
echo "📁 Creating various file types..."

# Create different types of files
echo "# Demo Project" > README.md
echo "console.log('Hello World');" > main.js
echo "*.log" > .gitignore
echo "node_modules/" >> .gitignore
echo "This is temporary" > temp.txt
mkdir -p src/utils
echo "export const helper = () => 'helper';" > src/utils/helper.js
echo "Debug information" > debug.log
mkdir node_modules
echo '{"name": "demo"}' > node_modules/package.json

echo ""
echo "📊 Testing JSON status in various scenarios..."
echo ""

# Scenario 1: Initial repository with untracked files
echo "=== Scenario 1: Initial repository with untracked files ==="
echo "Command: git status --json"
../git status --json
echo ""

# Scenario 2: Compare with traditional formats
echo "=== Scenario 2: Format comparison ==="
echo ""
echo "📝 Traditional long format:"
../git status
echo ""

echo "📝 Short format:"
../git status --short
echo ""

echo "📝 Porcelain format:"
../git status --porcelain
echo ""

echo "📝 JSON format:"
../git status --json
echo ""

# Scenario 3: Add some files to staging
echo "=== Scenario 3: Files in staging area ==="
../git add README.md main.js .gitignore
echo "Added README.md, main.js, and .gitignore to staging"
echo ""
echo "JSON output:"
../git status --json
echo ""

# Scenario 4: Make initial commit and test with branch info
echo "=== Scenario 4: After initial commit ==="
../git commit --quiet -m "Initial commit: Add README, main.js, and .gitignore"
echo "Made initial commit"
echo ""
echo "JSON output:"
../git status --json
echo ""

# Scenario 5: Mix of staged, unstaged, and untracked files
echo "=== Scenario 5: Mixed file states ==="
echo "// Updated with new feature" >> main.js  # Modify tracked file
../git add src/utils/helper.js  # Stage new file
echo "More temp data" >> temp.txt  # Keep file untracked
echo ""
echo "Now we have: staged (new file), unstaged (modified file), untracked (temp file)"
echo ""
echo "JSON output:"
../git status --json
echo ""

# Scenario 6: Test with ignored files
echo "=== Scenario 6: Including ignored files ==="
echo "JSON output with --ignored flag:"
../git status --json --ignored
echo ""

# Scenario 7: Detached HEAD scenario
echo "=== Scenario 7: Detached HEAD state ==="
../git checkout --quiet HEAD~0 2>/dev/null || true
echo "Checked out detached HEAD"
echo ""
echo "JSON output:"
../git status --json
echo ""

# Return to main branch
../git checkout --quiet main 2>/dev/null || true

echo "=== JSON Status Feature Summary ==="
echo ""
echo "✅ The --json flag provides structured output with:"
echo "   • Branch information (name, detached state)"
echo "   • Staged files array"
echo "   • Unstaged (modified) files array"
echo "   • Untracked files array"
echo "   • Ignored files array (with --ignored flag)"
echo ""
echo "🔥 Benefits:"
echo "   • No more regex parsing of status output"
echo "   • Perfect for CI/CD pipelines and automation"
echo "   • IDE integration friendly"
echo "   • Consistent machine-readable format"
echo ""
echo "🎯 Use cases:"
echo "   • Build systems checking for uncommitted changes"
echo "   • IDEs showing file states in project explorers"
echo "   • Pre-commit hooks analyzing repository state"
echo "   • Git GUIs displaying status information"
echo ""

# Cleanup
cd ..
rm -rf "$DEMO_DIR"

echo "Demo completed! The feature is ready for integration."
echo ""
echo "To use: git status --json"
