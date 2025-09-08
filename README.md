# Mac Developer Environment Setup — Overview & Quick Start

This repo contains everything Bryan used when setting up a modern, clean, and fast developer environment on macOS (Apple Silicon, tested on Sequoia 15.6.1).

## What’s Inside

- **Step-by-step setup log:**
  See [`2025-09-07-mac-mini-setup.md`](2025-09-07-mac-mini-setup.md) for the full, detailed guide.
- **Config backups:**
  - `zshrc-copy`: Z shell configuration
  - `starship-copy.toml`: Starship prompt config
  - `vscode-settings-copy.json`: VS Code settings
- **This README:** High-level summary, philosophy, and quick links.

## Setup Highlights

- **Shell:** zsh (default on macOS), enhanced with Starship for a minimal, informative prompt.
- **Navigation:** zoxide (smart cd), fzf (fuzzy search), eza (modern ls).
- **Environment:** direnv for per-project secrets and reproducibility.
- **Tools:** bat (highlighted cat), ripgrep (fast search), fd (find), jq/fx (JSON), httpie (API), tmux (multiplexing).
- **Languages:**
- Node/TypeScript via Volta (per-project, reproducible)
- Rust via rustup (with clippy, rustfmt)
- Python via uv (fast, isolated venvs)
- **Editor:** VS Code with Copilot, Rust Analyzer, Ruff, Prettier, ESLint, and GitLens. Font: JetBrains Mono Nerd Font for icons.

## Getting Started

1. **Read the [setup log](2025-09-07-mac-mini-setup.md)** for step-by-step instructions, commands, and verification steps.
2. **Restore configs** from the backup files if needed.
3. **Run smoke tests** (see setup log) to confirm everything works.

## Philosophy

We built this environment to be:

- **Clean:** Dotfolders and global installs are redirected to `~/Code/.dev` to keep `$HOME` tidy.
- **Fast:** All tools are chosen for speed and modern UX.
- **Reproducible:** Per-project environments, lockfiles, and clear config backups.
- **Secure:** Secrets and project settings are loaded only when needed.

## More Info

For full details, troubleshooting, and explanations, see [`2025-09-07-mac-mini-setup.md`](2025-09-07-mac-mini-setup.md).

---

_This README is your quick reference. For the full journey, see the setup log!_
