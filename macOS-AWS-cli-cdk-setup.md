# AWS CLI & IAM Identity Center (Multi‑Org) — Quick Setup

Goal: clean, scalable CLI access across **multiple AWS Organizations** using **IAM Identity Center (SSO)** — no static access keys.

---

## Account & Login Hygiene

**Email aliases (Gmail)**  
Use unique root + user aliases per account:

Example has a devs experimentation account, an account for their user group website, and a production website account with route53 domains. We use gmail "alias" by adding a + with an alias and this will automatically deliver to our main email. Where the devs email is `yourName@gmail.com`:

- Root: `yourName+aws-exp@gmail.com`, `yourName+aws-ug@gmail.com`, `yourName+yourName-website@gmail.com`
- Workforce user (Identity Center): `yourName+aws-exp-user@…`, etc.

**Browser separation**  

- In each profile: enable **AWS Multi‑Session** (Account menu → *Enable multi‑session*).  
- Set **account color** in Console to aid recognition.

**Password manager (Google Password Manager)**  

- Passkeys don’t support notes.  
- Use **passkey** for smooth sign‑in.  

---

## Local Directory Layout

We prefer keeping dev tools and configs out of `$HOME` and inside an easy to find environmental directory. Popular setup would be $~/Developer directory but <yours> prefers everything they create and its related environmental dependencies to be organized in /Code):

```bash
mkdir -p ~/Code/.dev/.aws
```

Update **~/.zshrc**:

```bash
export AWS_CONFIG_FILE="$HOME/Code/.dev/.aws/config"
export AWS_SHARED_CREDENTIALS_FILE="$HOME/Code/.dev/.aws/credentials"
```

Reload:

```bash
source ~/.zshrc
```

---

## Install Tools

```bash
brew install awscli
brew install session-manager-plugin

aws --version
session-manager-plugin
```

---

## Configure IAM Identity Center (per Org)

Repeat in each org (region recommended: **us‑west‑2** for Identity Center).

### Steps

1. Enable **AWS Organizations** (All features).  
2. Enable **IAM Identity Center** in the org’s chosen region.  
3. Create group `admins`.  
4. Create workforce user (e.g., `yourName-exp`, email: `…+aws-exp-user@…`).  
5. Add user to `admins`.  
6. Create permission set → *Predefined* → `AdministratorAccess` (set session to 8–12h).  
7. Assign `admins` to the account with that permission set.  
8. Confirm the access portal URL looks like `https://d-XXXXXXXXXX.awsapps.com/start/`.  

> The access portal must show an **account card** (e.g., *AdministratorAccess*) after assignment. If empty, permissions are missing.

---

## CLI SSO — Multi‑Org Layout

Use one `sso-session` per org, then one profile per account/role.

**Example `~/Code/.dev/.aws/config`:**

```ini
# --- SSO sessions (one per Organization) ---
[sso-session exp-org]
sso_start_url = https://<yours>.awsapps.com/start/
sso_region = us-west-2
sso_registration_scopes = sso:account:access

[sso-session ug-org]
sso_start_url = https://<yours>.awsapps.com/start/
sso_region = us-west-2
sso_registration_scopes = sso:account:access

[sso-session web-org]
sso_start_url = https://<yours>.awsapps.com/start/
sso_region = us-west-2
sso_registration_scopes = sso:account:access

# --- Profiles (per account/role) ---
[profile experimental-admin]
sso_session = exp-org
sso_account_id = <yours>
sso_role_name  = AdministratorAccess
region = us-west-2

[profile <yours>ug-admin]
sso_session = ug-org
sso_account_id = <yours>
sso_role_name  = AdministratorAccess
region = us-west-2

[profile web-admin]
sso_session = web-org
sso_account_id = <yours>
sso_role_name  = AdministratorAccess
region = us-west-2
```

**First-time login per org:**

```bash
aws sso login --sso-session exp-org
aws sso login --sso-session ug-org
aws sso login --sso-session web-org
```

**Use any profile:**

```bash
aws sts get-caller-identity --profile experimental-admin
AWS_PROFILE=<yours>ug-admin aws s3 ls
```

Tokens are cached per `sso-session`, so you can stay logged into all orgs simultaneously.

---

## SSM Session Manager Test

```bash
aws ssm start-session --target i-0123456789abcdef --profile experimental-admin
```

Ensure:

- The instance has the **SSM Agent** installed.  
- IAM role attached includes **AmazonSSMManagedInstanceCore**.  
- Instance is in a supported region and VPC path.

---

## AWS CDK with SSO Profiles

Install and verify CDK:

```bash
npm i -g aws-cdk
cdk --version
```

Bootstrap each account with the correct profile:

```bash
cdk bootstrap --profile experimental-admin aws://<yours>/us-west-2
cdk bootstrap --profile <yours>ug-admin aws://<yours>/us-west-2
cdk bootstrap --profile web-admin      aws://<yours>/us-west-2
```

Scaffold a project:

```bash
mkdir -p ~/Code/Projects/ultron-embeddings/infra
cd ~/Code/Projects/ultron-embeddings/infra
cdk init app --language typescript

npm install aws-cdk-lib constructs
```

Deploy:

```bash
cdk synth  --profile experimental-admin
cdk deploy --profile experimental-admin
```

Or use:

```bash
AWS_PROFILE=<yours>ug-admin cdk deploy
```

---

## 🔑 Key Management & Security Best Practices

Modern developers avoid hardcoding secrets (API keys, database passwords, cloud credentials) in code. Instead, secrets are managed securely across tools, environments, and identity providers.

### Environment Variables & Local Development

- Use `.env` files with [`direnv`](https://direnv.net/) for auto-loading per project:
  ```bash
  brew install direnv
  echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
  source ~/.zshrc
  
  # In your project:
  echo 'use dotenv' > .envrc
  direnv allow
  ```
- Always add `.env` to `.gitignore`
- Encrypt sensitive `.env` backups: `gpg -c .env`

### Secret Leak Prevention

Install [`git-secrets`](https://github.com/awslabs/git-secrets) to block secret leaks:
```bash
brew install git-secrets
git secrets --install
git secrets --register-aws
```

### GitHub Authentication

Use CLI + SSH keys stored in macOS Keychain:
```bash
# GitHub CLI
brew install gh
gh auth login

# SSH keys
ssh-keygen -t ed25519 -C "your-email@example.com"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

### AWS-First Secret Management Defaults

- **Humans**: IAM Identity Center (SSO) — no static IAM keys
- **Applications**: IAM roles with STS/OIDC federation  
- **Secrets**: AWS Secrets Manager for rotation, SSM Parameter Store for config
- **Encryption**: AWS KMS for cryptographic operations
- **CI/CD**: GitHub Actions → OIDC → IAM role → temporary STS credentials

---

## Tips & Guardrails

- Avoid static access keys for admin users.  
- Use Gmail filters for aliases (`root`, `user`).  
- Maintain an offline record of MFA device types (no secrets).

---

## Troubleshooting

- Access portal shows no accounts → group/user not assigned a permission set.  
- CLI says “device code” can’t find session → wrong Start URL or region.  
- CDK deploy fails → run `aws sso login --profile …`.  
- Session expired → re‑run `aws sso login` for the affected profile.

---

## Quick Commands

```bash
# Create config dir and point CLI to it
mkdir -p ~/Code/.dev/.aws
echo 'export AWS_CONFIG_FILE="$HOME/Code/.dev/.aws/config"' >> ~/.zshrc
echo 'export AWS_SHARED_CREDENTIALS_FILE="$HOME/Code/.dev/.aws/credentials"' >> ~/.zshrc
source ~/.zshrc

# Install tools
brew install awscli session-manager-plugin

# First-time SSO logins per org
aws sso login --sso-session exp-org
aws sso login --sso-session ug-org
aws sso login --sso-session web-org

# Validate
aws sts get-caller-identity --profile experimental-admin
```

---

You now have clean, scalable, multi‑org CLI access via IAM Identity Center, SSM ready, and CDK wired to the right profiles.
