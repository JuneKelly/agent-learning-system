#!/bin/bash

set -e

PLATFORM="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMAND_DIR="$SCRIPT_DIR/command"

print_usage() {
  echo "Usage: $0 <platform>"
  echo ""
  echo "Platforms:"
  echo "  opencode     Install for OpenCode (~/.config/opencode/command/)"
  echo "  claude-code  Install for Claude Code (~/.claude/commands/)"
  echo ""
  echo "Example:"
  echo "  $0 opencode"
}

if [ -z "$PLATFORM" ]; then
  echo "Error: Platform argument required"
  echo ""
  print_usage
  exit 1
fi

case "$PLATFORM" in
  opencode)
    DEST_DIR="$HOME/.config/opencode/command"
    PLATFORM_NAME="OpenCode"
    ;;
  claude-code)
    DEST_DIR="$HOME/.claude/commands"
    PLATFORM_NAME="Claude Code"
    ;;
  *)
    echo "Error: Unknown platform '$PLATFORM'"
    echo ""
    print_usage
    exit 1
    ;;
esac

echo "Installing Agent Learning System for $PLATFORM_NAME..."
echo ""

if [ ! -d "$COMMAND_DIR" ]; then
  echo "Error: Command directory not found at $COMMAND_DIR"
  exit 1
fi

if [ ! -d "$DEST_DIR" ]; then
  echo "Creating directory: $DEST_DIR"
  mkdir -p "$DEST_DIR"
fi

INSTALLED=0
SKIPPED=0

for file in "$COMMAND_DIR"/*.md; do
  if [ ! -f "$file" ]; then
    continue
  fi
  
  filename=$(basename "$file")
  dest="$DEST_DIR/$filename"
  
  if [ -L "$dest" ]; then
    current_target=$(readlink "$dest")
    if [ "$current_target" = "$file" ]; then
      echo "  ✓ $filename (already installed)"
      ((SKIPPED++))
      continue
    else
      echo "  → $filename (updating symlink)"
      rm "$dest"
    fi
  elif [ -e "$dest" ]; then
    echo "  ⚠ $filename (file exists, skipping)"
    ((SKIPPED++))
    continue
  else
    echo "  + $filename"
  fi
  
  ln -s "$file" "$dest"
  ((INSTALLED++))
done

echo ""
echo "Installation complete!"
echo "  Installed: $INSTALLED commands"
if [ $SKIPPED -gt 0 ]; then
  echo "  Skipped:   $SKIPPED commands"
fi
echo ""
echo "Commands installed to: $DEST_DIR"
echo ""
echo "Next steps:"
echo "  1. Add '**/.tmp/**' to your project's .gitignore"
echo "  2. Start a new session with your AI agent"
echo "  3. Use /learning-recall to load previous learnings"
echo "  4. Use /learning-summarise and /learning-store when you teach the agent something new"