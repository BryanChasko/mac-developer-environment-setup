# Terminal Profile Customization

Visually distinct terminal prompts for multi-machine workflows. At a glance:

- Mac Mini = warm tones (peach, maroon, flamingo, mauve, pink)
- ROCm AIBox = cool tones (blue, teal, yellow, green)

Both use Catppuccin Mocha palette with Starship powerline segments.

## What changed

### Starship prompts

Both machines now run powerline-style Starship prompts with OS icon, username, hostname, directory, git, language, and duration segments. The color temperature is the differentiator:

| Segment    | Mac Mini (warm)     | AIBox (cool)        |
|------------|---------------------|---------------------|
| OS/user    | peach `#fab387`     | blue `#89b4fa`      |
| hostname   | maroon `#eba0ac`    | teal `#94e2d5`      |
| directory  | flamingo `#f2cdcd`  | yellow `#f9e2af`    |
| git        | mauve `#cba6f7`     | green `#a6e3a1`     |
| languages  | pink `#f5c2e7`      | blue `#89b4fa`      |
| cursor     | peach `#fab387`     | green `#a6e3a1`     |

### Terminal.app profiles

- `catppuccin-mocha` — default local profile, Mocha base background `#1e1e2e`
- `rocm-ssh` — SSH profile, Macchiato base background `#24273a` (blue-shifted)

### SSH wrapper (in .zshrc)

A `ssh()` function wraps the real ssh command. When connecting to `rocm-aibox`:
1. Switches Terminal.app to the `rocm-ssh` profile
2. Sets window title to "SSH: rocm-aibox"
3. On disconnect, reverts to `catppuccin-mocha` and clears the title

### Secrets cleanup

- Hardcoded GitHub PAT removed from Mac Mini .zshrc
- `.zshrc` now sources `~/.secrets` for any sensitive env vars
- Dynamic token via `$(gh auth token)` handles GitHub auth
- AIBox has similar hardcoded keys that need the same treatment

## Deploy

```sh
# Mac Mini
cp terminal-profiles/starship-mac-mini-warm.toml ~/.config/starship.toml

# AIBox (via SSH)
scp terminal-profiles/starship-aibox-cool.toml bryanchasko@rocm-aibox.local:~/.config/starship.toml
```

## Manual step: create ~/.secrets

```sh
cat > ~/.secrets << 'EOF'
# ~/.secrets — shell environment overrides
# Sourced by ~/.zshrc. Never commit this file.
# Add environment overrides below.
EOF
chmod 600 ~/.secrets
```

Rotate any tokens that were previously hardcoded in shell configs.
