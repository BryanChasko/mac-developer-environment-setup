# Mac mini Developer Environment — Full Setup Log (2025-09-07)

> **Reference Machine:** Apple Mac Mini (M2, 16 GB RAM), macOS Sequoia 15.6.1

Welcome! This is the step-by-step log from setting up a modern developer environment on macOS (Apple Silicon). For a quick summary and philosophy, see the [README](README.md).

## At a Glance

- Visual Studio Code with Copilot and key extensions
- Homebrew for package management
- zsh shell, Starship prompt, navigation helpers
- Node/TypeScript (Volta), Rust (rustup), Python (uv)
- Clean config management and dotfolder redirection
- Smoke tests for Node, Rust, Python

For a summary, see [README.md](README.md). For config backups, see files in this directory.

---

## Step 0 — VS Code & GitHub Copilot

Launch VS Code

**VS Code:**
Open the Command Palette (`Cmd+Shift+P`), type "shell command", and run "Install 'code' command in PATH".
Restart your terminal for the new `$PATH` to take effect. You can now type `code .` in any folder to launch VS Code there.

**GitHub Copilot:**
Provides AI code suggestions directly inside VS Code.

### Actions Completed

- Confirmed sign-in with GitHub
- Tested inline suggestions successfully

### Verification

Open any code file in VS Code and begin typing — Copilot should offer gray ghost-text completions inline.

---

## Step 1 — Prerequisites

### 1.1 Homebrew

Homebrew is the standard package manager for macOS. It lets us install and update developer tools easily.

**Install Homebrew** (Apple Silicon default path is `/opt/homebrew`):

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Add Homebrew to zsh:**

```sh
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

**Verify Homebrew:**

```sh
brew --version
brew update
```

### 1.2 CLI Tools

**Git + GitHub CLI:**

```sh
brew install git gh gpg pinentry-mac
```

**Search & Navigation Helpers:**

```sh
brew install fzf ripgrep fd jq zoxide eza
```

**Prompt, Environment Managers, Multiplexer:**

```sh
brew install starship direnv tmux
```

**Better cat + HTTP Tools:**

```sh
brew install bat httpie fx
```

#### Notes

- `fzf` — fuzzy finder (Ctrl+R search through history, fuzzy search files)
- `ripgrep (rg)` — super fast text search in projects
- `fd` — user-friendly alternative to find
- `jq` — JSON parser
- `zoxide` — smarter cd
- `eza` — modern ls
- `starship` — universal shell prompt (clean + fast)
- `direnv` — per-project environment variables (keeps secrets out of Git)
- `tmux` — terminal multiplexer (splits + persistence)
- `bat` — cat with syntax highlighting
- `httpie` — clean HTTP client for APIs
- `fx` — interactive JSON viewer

### 1.3 Fonts & Apps

**Fonts:** Nerd Fonts are needed for icons in Starship/eza

```sh
brew install --cask font-jetbrains-mono-nerd-font
```

**Terminals + Editors:**

```sh
brew install --cask iterm2
```

### 1.4 Verification

Check each tool is in PATH and working:

```sh
zoxide --version
fzf --version
eza --version
direnv --version
bat --version
```

---

## Step 2 — zsh Configuration

### 2.1 Configure `~/.zshrc` with Starship, zoxide, fzf, direnv, and DEV_HOME redirection

zsh is the default shell on macOS. The `~/.zshrc` file is run every time an interactive shell session starts, and it’s where we configure paths, prompts, tools, aliases, and environment redirection for a clean home directory.

Update your `~/.zshrc` with the following (see `zshrc-copy` for a backup):

```sh
# --- Homebrew in PATH (Apple Silicon) ---
eval "$(/opt/homebrew/bin/brew shellenv)"

# --- DEV_HOME redirection for dotfolders ---
export DEV_HOME="$HOME/Code/.dev"
export CARGO_HOME="$DEV_HOME/.cargo"
export RUSTUP_HOME="$DEV_HOME/.rustup"
export NPM_CONFIG_PREFIX="$DEV_HOME/.npm-global"
export VOLTA_HOME="$HOME/.volta"   # Volta must stay first in PATH
export PATH="$VOLTA_HOME/bin:$DEV_HOME/.npm-global/bin:$HOME/.local/bin:$PATH"

# --- Prompt (Starship): fast & readable ---
eval "$(starship init zsh)"

# --- Navigation helpers ---
eval "$(zoxide init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- Per-project envs (direnv) ---
eval "$(direnv hook zsh)"

# --- zsh plugins (optional, via brew) ---
# brew install zsh-autosuggestions zsh-syntax-highlighting
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2>/dev/null

# --- Friendly aliases ---
alias ls="eza --group-directories-first --icons"
alias ll="eza -l --group-directories-first --icons"
alias la="eza -la --group-directories-first --icons"
alias gs="git status -sb"
alias cat="bat --style=plain --paging=never"

# --- Editor preference ---
export EDITOR="vim"
export VISUAL="$EDITOR"

# --- Default working directory ---
cd "$HOME/Code"

# --- Python venvs location ---
export UV_VENV_HOME="$DEV_HOME/.venvs"

```

```sh
starship --version
zoxide --version
fzf --version
direnv --version
```

### 2.2 Add Aliases

- `ll`, `gs`, `cat → bat`

**Verify configuration:**

```sh
ls
ll
la
gs
cat ~/.zshrc
```

You'll see styling and permissions as you use these tools, e.g.:

 code  Desktop 󰲂 Documents 󰉍 Downloads  Library 󰿎 Movies 󱍙 Music 󰉏 Pictures  Public
drwxr-xr-x@ - bryanchasko 7 Sep 10:53  code
drwx------ - bryanchasko 6 Sep 10:28  Desktop

---

## Step 3 — Languages

### 3.1 Node/TypeScript via Volta

```sh
brew install volta
volta install node@lts pnpm yarn
volta install typescript typescript-language-server eslint prettier
node -v && pnpm -v && tsc -v
```

**Add Volta to PATH:**

```sh

## --- Volta (Node/TS toolchain shims) ---

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
```

**Reload the shell:**

```sh
exec zsh -l
```

**Verify installations:**

```sh
which node && node -v
which pnpm && pnpm -v
which yarn && yarn -v
which tsc && tsc -v
which typescript-language-server && typescript-language-server --version
which eslint && eslint -v
which prettier && prettier -v
```

Example output:

/Users/bryanchasko/.volta/bin/node
v22.19.0
/Users/bryanchasko/.volta/bin/pnpm
10.15.1
/Users/bryanchasko/.volta/bin/yarn
4.9.4
/Users/bryanchasko/.volta/bin/tsc
Version 5.9.2
/Users/bryanchasko/.volta/bin/typescript-language-server
4.4.0
/Users/bryanchasko/.volta/bin/eslint
v9.35.0
/Users/bryanchasko/.volta/bin/prettier
3.6.2

### 3.2 Rust via rustup

**Install Rust toolchain:**

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

When prompted by the installer:

```text

1) Proceed with standard installation (default - just press enter)
2) Customize installation
3) Cancel installation
>
```

Select option 1 (just press Enter) to proceed with the standard installation.

**Add Rust to PATH:**

```sh

## --- Rust toolchain ---

source "$HOME/.cargo/env"
```

Add the above line to your `~/.zshrc` to ensure Rust is available in all new terminal sessions.

**Install additional components:**

```sh
rustup component add rust-analyzer clippy rustfmt
```

**Verify installations:**

```sh
rustc --version
cargo --version
rust-analyzer --version
cargo clippy --version
cargo fmt --version
```

### 3.3 Python via uv

**Install uv (fast Python package manager):**

```sh
curl -LsSf <https://astral.sh/uv/install.sh> | sh
```

The installer places `uv` in `$HOME/.local/bin`. To use `uv` in your shell, add this to your environment:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

**Set all Python virtual environments to one place:**

```sh
export UV_VENV_HOME="$HOME/Code/.dev/.venvs"
```

Add the above lines to your `~/.zshrc` for persistence.

**Why uv?**

- Fast virtual environments and package resolution
- Lock files for reproducible builds
- Better dependency management than pip/pipenv
- Built in Rust for speed

**Verify installation:**

```sh
uv --version

## Example output

uv 0.8.15 (8473ecba1 2025-09-03)
```

---

## Step 4 — VS Code Integration

### 4.1 Extensions

**Install via CLI (repeatable):**

```sh
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat
code --install-extension rust-lang.rust-analyzer
code --install-extension charliermarsh.ruff
code --install-extension esbenp.prettier-vscode
code --install-extension dbaeumer.vscode-eslint
```

All recommended extensions were installed or already present:

- GitHub Copilot
- GitHub Copilot Chat
- Rust Analyzer
- Ruff (Python)
- Prettier
- ESLint

### 4.2 Settings Configuration

**Workspace settings:**

Created `.vscode/settings.json` in the workspace with the following recommended configuration:

```json
{
  "editor.fontFamily": "'JetBrains Mono Nerd Font', Menlo, Monaco, 'Courier New', monospace",
  "editor.fontSize": 14,
  "editor.formatOnSave": true,
  "editor.rulers": [80, 120],
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "[rust]": {
    "editor.defaultFormatter": "rust-lang.rust-analyzer"
  },
  "[python]": {
    "editor.defaultFormatter": "charliermarsh.ruff"
  }
}
```

## This ensures consistent formatting and editor experience for all contributors in this workspace.

## Step 5 — Git Hygiene

### 5.1 Configure Git Defaults

**Set global configuration:**

```sh
git config --global init.defaultBranch main
git config --global user.name "Bryan Chasko"
# Personal email configuration - see ~/Code/Projects/Marvel-API-Private/docs/git-personal-config.md
git config --global user.email "YOUR_EMAIL"
git config --global core.autocrlf input
git config --global core.whitespace trailing-space,space-before-tab
```

> **Personal Email:** For actual email value, authorized users should reference the private configuration in `~/Code/Projects/Marvel-API-Private/docs/git-personal-config.md`

> Note: `.npmrc` exists with prefix pointing to `~/Code/.dev/.npm-global` for global npm installs.

### 5.2 GPG Signing (Optional)

**GPG is already installed via Homebrew. To set up signed commits:**

```sh

## Generate key (follow prompts)

gpg --full-generate-key

## List keys and copy the key ID

gpg --list-secret-keys --keyid-format=long

## Configure Git to use GPG

git config --global user.signingkey YOUR_KEY_ID
git config --global commit.gpgsign true
```

---

## Step 6 — Smoke Tests

### 6.1 Node.js Test

```sh
node -e "console.log('hello ts')"
```

**Expected output:**

```text
hello ts
```

### 6.2 Rust Test

```sh
cargo new hello && cd hello && cargo run
```

**Expected output:**

```text
  Created binary (application) `hello` package
   Compiling hello v0.1.0 (/path/to/hello)
    Finished dev [unoptimized + debuginfo] target(s) in 1.23s
  Running `target/debug/hello`
Hello, world!
```

### 6.3 Python Test

```sh
uv run python -c "print('hello py')"
```

**Expected output:**

```text
hello py
```

---

## Step 7 — Additional Styling & Organization

- Starship configuration (`starship.toml`)
- iTerm2 transparency
- zsh-autosuggestions
- zsh-syntax-highlighting
- Default working directory is now `~/Code` (set in `.zshrc`)
- Hidden dotfolders (e.g. `.cargo`, `.npm`, `.rustup`, `.venvs`) were symlinked into `~/Code/.dev` to keep `$HOME` visually clean

### 7.1 Xcode Command Line Tools

Required for compilers (clang, Rust, etc.):

```sh
xcode-select --install
```

Verify installation:

```sh
xcode-select -p

## Should output: /Library/Developer/CommandLineTools
```

### 7.2 GitHub Integration

GitHub CLI authentication and integration completed:

```sh
gh auth login
```

We have the github mobile app and use that to MFA our login

### 7.3 VS Code Python Extension

Install for interpreter selection and debugging:

```sh
code --install-extension ms-python.python
```

### 7.4 Confirm uv PATH in ~/.zshrc

Ensure this line is present:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

To confirm:

```sh
cat ~/.zshrc | grep 'export PATH="$HOME/.local/bin:$PATH"'

## Should output the line above if present
---

**For a summary and config backups, see [README.md](README.md) and the files in this directory.**
