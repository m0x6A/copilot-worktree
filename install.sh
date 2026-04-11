#!/usr/bin/env bash
set -euo pipefail

REPO="m0x6a/copilot-worktree"
BRANCH="main"
INSTALL_DIR="${CWT_INSTALL_DIR:-$HOME/.local/bin}"
RAW_URL="https://raw.githubusercontent.com/$REPO/$BRANCH"

echo "Installing cwt..."

# Check dependencies
missing=()
command -v git >/dev/null 2>&1 || missing+=(git)
command -v gh  >/dev/null 2>&1 || missing+=(gh)

if [ ${#missing[@]} -gt 0 ]; then
    echo "Error: missing required commands: ${missing[*]}" >&2
    exit 1
fi

# Check for a dictionary file (Fedora, Ubuntu/Debian, macOS, fallbacks)
dict_found=false
for f in \
    /usr/share/dict/words \
    /usr/share/dict/american-english \
    /usr/share/dict/british-english \
    /usr/share/dict/web2 \
    /usr/share/cracklib/cracklib-small; do
    if [ -f "$f" ]; then
        dict_found=true
        break
    fi
done

if [ "$dict_found" = false ]; then
    echo "Warning: no dictionary file found." >&2
    echo "Install one for your platform:" >&2
    echo "  Fedora:        sudo dnf install words" >&2
    echo "  Ubuntu/Debian: sudo apt install wamerican" >&2
    echo "  Arch:          sudo pacman -S words" >&2
    echo "  macOS:         (should exist at /usr/share/dict/words)" >&2
    exit 1
fi

# Install
mkdir -p "$INSTALL_DIR"
curl -fsSL "$RAW_URL/bin/cwt" -o "$INSTALL_DIR/cwt"
chmod +x "$INSTALL_DIR/cwt"

# Verify PATH
if ! echo "$PATH" | tr ':' '\n' | grep -qx "$INSTALL_DIR"; then
    echo ""
    echo "Note: $INSTALL_DIR is not in your PATH."
    echo "Add this to your shell profile (~/.bashrc, ~/.zshrc, etc.):"
    echo ""
    echo "  export PATH=\"$INSTALL_DIR:\$PATH\""
    echo ""
fi

echo "Installed cwt to $INSTALL_DIR/cwt"
echo ""
echo "Usage: cd into any git repo and run:"
echo "  cwt"
