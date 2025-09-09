# Mac Developer Environment Setup — Overview & Quick Start

This organizes the tooling Bryan deployed when setting up a cloud-first developer environment on macOS (Apple Silicon, tested on Sequoia 15.6.1), capable of handling light rust, python, and javascript workloads locally as part of ongoing GenAI project work as well as contracting customer/community needs. 

## Bias

Preference for zsh shell [historically have enjoyed oh-my-zsh], vim, VSCode, transparent or light gradient graphic backgrounds, highly accessible fonts/colors, readiness to work in current versions of Python, Rust, and Typescript with autocompliance to best practices on file saves, tons of linting, and lots of autocompletion available.  Documentation orgranized into md files soas to be lightweight and friendly to crawlers and scrapers for LLM ease of use. Desire to keep root user directory (containing downloads, documents, etc) separate from code environment stuff, will lead to containerization and deployment of AWS CodeCatalyst [https://codecatalyst.aws/explore/dev-environments], and evaluate containerization. For now, need to connect to and deploy REST API tooling, secure aws account cli / cdk access to depoy - JSONL for embeddings and interchange. 

## Contributing Principles

- Aim for clean, working code consistent with a Rust-preferred, 
  JSONL-centered architecture, abstraction towards quick task completion prioritizes Serverless / Vercel architectures.
- Prefer improvement and consolidation over duplication.
- Reject fragile hacks, unchecked errors, or untested code.
- Maintain predictable structure and clear tests.



## To-dos for this tooling

- Add automated corrections on files save, i.e. length
- Add Perl and Shell automations to deploy this tooling automagically, test on aws device farm &/or ec2 bare metal
- Add Docker support.
- Test current AWS 3D work environments / response with wacom, to see if game dev is possible on newer mac minis.

## What’s Inside

- Python via uv (fast, isolated venvs)

**Editor:**

VS Code with Copilot, Rust Analyzer, Ruff, Prettier, ESLint, and GitLens. 

Font: JetBrains Mono Nerd Font for icons.

## Getting Started

1. **Read the [setup log](2025-09-07-mac-mini-setup.md)** for step-by-step instructions, commands, and verification steps.

3. **Run smoke tests** (see setup log) to confirm everything works.


We built this environment to be:

- **Fast:** All tools are chosen for speed and modern UX.
- **Reproducible:** Per-project environments, lockfiles, and clear config backups.
- **Secure:** Secrets and project settings are loaded only when needed.

## More Info

For full details, troubleshooting, and explanations, see [`2025-09-07-mac-mini-setup.md`](2025-09-07-mac-mini-setup.md).

---

## To-dos for Bryan [convert to github issues]

- setup rest api toolchain

- spend more time customizing backgrounds, icons, etc

- Test REST API tooling use case:
https://developer.marvel.com/
(sign in with your Disney Plus account 🐭)

### AWS CLI & SSM Plugin (Next Step)

We have two AWS accounts:

- One for websites
- One for R&D experimentation

Install AWS CLI and SSM plugin:

```sh
brew install awscli
brew install session-manager-plugin
```

Configure both AWS accounts:

```sh
aws configure --profile websites
aws configure --profile rnd
```

Switch between accounts using the `--profile` flag as needed. Make sure both are set up and tested.

All other setup steps are complete and verified. Once AWS CLI is installed and both accounts are configured, your Mac developer environment will be fully provisioned.

- Test AWS use case:
AWS S3 for storage (bucket: `ultron-embeddings-<account-id>`).

- Create data ingestion pipeline to assemble ultron embeddings.
[https://github.com/BryanChasko/ultron-embeddings]

- Integrate Terraform.

_This README is your quick reference. For the full environment setup walkthrough, see the setup log in [2025-09-07-mac-mini-setup.md]
