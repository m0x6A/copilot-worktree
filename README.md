# cwt — Copilot Worktree

Spin up GitHub Copilot in an isolated git worktree with a single command.

`cwt` creates a fresh worktree under `.github/worktrees/` named whatever you pass it, or a memorable random name (e.g., `alpine-cactus-horizon`), and drops you straight into a `copilot` session inside it.

## Install

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/m0x6a/copilot-worktree/main/install.sh)"
```

Or with a custom install directory:

```sh
CWT_INSTALL_DIR=/usr/local/bin sh -c "$(curl -fsSL https://raw.githubusercontent.com/m0x6a/copilot-worktree/main/install.sh)"
```

## Usage

```sh
cd your-repo
cwt                     # random name, e.g. alpine-cactus-horizon
cwt fun-little-feature  # or pick your own
```

This will:

1. Use the given name, or generate one from 3 random dictionary words
2. Create a git worktree at `.github/worktrees/<name>` with a matching branch
3. Launch `copilot` inside it

Each invocation creates a new, isolated worktree — your main working tree stays untouched.

## Requirements

- [git](https://git-scm.com/)
- [GitHub Copilot CLI](https://github.com/github/copilot-cli) (`copilot`)
- A system dictionary file (only needed for random names) — `cwt` auto-detects these locations:

| Platform | Dictionary path | Install command |
|---|---|---|
| **Fedora** | `/usr/share/dict/words` | `sudo dnf install words` |
| **Ubuntu/Debian** | `/usr/share/dict/american-english` | `sudo apt install wamerican` |
| **Arch** | `/usr/share/dict/words` | `sudo pacman -S words` |
| **macOS** | `/usr/share/dict/words` | included by default |

`shuf` (coreutils) is used when available. On macOS without coreutils, `cwt` falls back to `awk`/`sort` automatically — no extra dependencies needed.

## Uninstall

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/m0x6a/copilot-worktree/main/uninstall.sh)"
```

Or just delete the binary:

```sh
rm ~/.local/bin/cwt
```

## Cleanup worktrees

To remove worktrees created by `cwt`:

```sh
# List all worktrees
git worktree list

# Remove a specific one
git worktree remove .github/worktrees/<name>

# Prune stale entries
git worktree prune
```

## License

MIT
