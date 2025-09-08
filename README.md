# Dev log and setup instructions for Mac AWS dev environment setup with VS Code

## Objectives (Completed)

- Install Visual Studio Code
- Get GitHub Copilot working in VS Code
- Install Homebrew package manager
- Configure zsh with Starship, zoxide, fzf, direnv
- Add aliases (`ll`, `gs`, `cat → bat`)
- Install Node/TypeScript via Volta
- Install Rust toolchain
- Install Python (uv) toolchain
- Integrate with VS Code (extensions, PATH, settings)
- Verify with smoke tests

This directory contains:

- Backup copies of key config files (`zshrc`, `starship.toml`)
- Step-by-step setup documentation
- Recommendations for security and documentation hygiene

## Files

- `zshrc`: Z shell configuration
- `starship.toml`: Starship prompt configuration
- `2025-09-07-mac-mini-setup.md`: Full setup log and instructions

## README

For our Apple M2 Mac Mini with 16 GB memory, currently on macOS Sequoia 15.6.1, we built a developer environment that’s clean, fast, and reliable.

The shell is zsh, already the default on macOS, but we integrated Starship for a minimal but informative prompt — git branches, language versions, or time.

To keep navigation smooth we added zoxide, which learns where we go and makes directory changes nearly instant, and fzf, which turns history and file searches into fuzzy-filtered menus. eza replaced the default ls, giving cleaner output with icons and colors.

For environment management we brought in direnv. Instead of cluttering global configs with secrets or project settings, direnv loads them only when you’re in a project folder. This keeps things reproducible and safe, which lifts security standards.

Tools that make daily work easier: bat for highlighted file views, ripgrep for lightning-fast searches, fd as a simpler find, jq and fx for parsing JSON, httpie for working with APIs, and tmux for splitting and persisting terminal sessions. Each one makes output clearer and workflows quicker, replacing older, noisier tools with modern ones designed for clarity.

For languages, we chose Volta to manage Node and TypeScript. It installs Node, pnpm, yarn, and TypeScript tooling in a way that’s both per-project and reproducible, so there’s no confusion about versions. For Rust, we installed rustup, the official toolchain manager, and added clippy and rustfmt to enforce linting and formatting standards. Together, they ensure every project compiles consistently and cleanly. Python will be handled with uv, giving fast installs and isolated environments aligned with the same philosophy as Volta and direnv.

We tied all this into VS Code with GitHub Copilot for AI suggestions, Rust Analyzer, Ruff, Prettier, ESLint, and GitLens. The editor and terminal are both expected to enforce standards. The font, JetBrainsMono Nerd Font Mono in size 13 regular, brings in the icons that starship and eza use, while iTerm2 adds transparency and blurs.
