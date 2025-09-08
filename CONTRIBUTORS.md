# Workflow

1. Fork the repository.
2. Create a branch with a descriptive name (e.g., `feature/dev-environment-upgrade`, `fix/vercel-integration-path`).
3. Commit with decisive, clear messages.
4. Open a PR with a concise description and adherence to standards.
5. Include tests and run CI checks:
    - `cargo build --workspace`
    - `cargo test --workspace`
    - `cargo fmt -- --check`
    - `cargo clippy -- -D warnings`
    - `cdk synth` (infra)

## Language & Tone

Contributors should use a technical, deliberate tone. Documentation and 
messages should be precise and action-oriented.

