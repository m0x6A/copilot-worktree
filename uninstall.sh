#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="${CWT_INSTALL_DIR:-$HOME/.local/bin}"

if [ -f "$INSTALL_DIR/cwt" ]; then
    rm "$INSTALL_DIR/cwt"
    echo "Removed $INSTALL_DIR/cwt"
else
    echo "cwt is not installed at $INSTALL_DIR/cwt"
fi
