# mac mini infrastructure state — 2026-04-04

> last verified by heraldstack automated audit

## runtime versions

| tool | version | managed by | path |
|------|---------|------------|------|
| node | 25.9.0 | volta 2.0.2 | `~/Code/.dev/.volta/bin/node` |
| npm | 11.12.1 | volta | `~/Code/.dev/.volta/bin/npm` |
| volta | 2.0.2 | self-installed | `~/Code/.dev/.volta/bin/volta` |

volta home: `~/Code/.dev/.volta`
volta stores node versions at `~/Code/.dev/.volta/tools/image/node/` (22.19.0, 24.14.1, 25.9.0 installed)

## git + github

- SSH key: `~/.ssh/id_ed25519` — registered with BryanChasko GitHub account
- github.com in `~/.ssh/known_hosts`
- `gh` CLI: v2.83.2 via homebrew (`/opt/homebrew/bin/gh`) — authenticated
- homebrew not on PATH in SSH sessions — use full path `/opt/homebrew/bin/gh` or source `~/.zprofile` first
- repos under `chasko-labs` org — use `git@github.com:chasko-labs/<repo>.git` for clones

## launchd services

### com.csvautomator.chrome-daemon

chrome-launch-daemon for CSV Course Automator extension testing

- plist: `~/Library/LaunchAgents/com.csvautomator.chrome-daemon.plist`
- working dir: `~/Code/chrome-extension-moodle-uploader-src` (git clone from chasko-labs)
- node binary: volta shim (`~/Code/.dev/.volta/bin/node`) — auto-tracks default node version
- logs: `~/.chrome-launch-daemon/logs/`
- port file: `~/.chrome-launch-daemon/daemon.port`
- KeepAlive: true, RunAtLoad: true

## directory layout

| path | purpose | size | git |
|------|---------|------|-----|
| `~/Code/chrome-extension-moodle-uploader-src/` | extension source (git clone) | 750M | chasko-labs/chrome-extension-moodle-uploader |
| `~/Code/chrome-extension-moodle-uploader-dist/` | built extension (flat copy) | 1.4M | no |
| `~/Code/mac-developer-environment-setup/` | this repo | 352K | chasko-labs/mac-developer-environment-setup |
| `~/Code/Google Chrome for Testing.app/` | CfT binary for extension testing | 336M | no |
| `~/Code/ComfyUI/` | ML image generation (future pipeline) | 7.9G | no |
| `~/Code/.dev/.volta/` | volta node toolchain | — | no |

## ssh config

`~/.ssh/config` has aliases for rocm-aibox (rocm workstation) and haunting environments (placeholder IPs)

## action items

- homebrew volta (uses manual install at `~/Code/.dev/.volta`) — consider switching to `brew install volta`
- no crontab entries
- no launchd git-sync agents (chrome-ext-src is now a git clone — pull manually or add sync)
