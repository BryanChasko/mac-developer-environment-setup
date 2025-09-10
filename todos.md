**Rust HTTP Client Libraries (add to Cargo.toml):**

```toml
[dependencies]
reqwest = { version = "0.11", features = ["json"] }
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
tokio = { version = "1.0", features = ["full"] }
md5 = "0.7"
```

**VS Code Extensions for API Work:**

```sh
code --install-extension humao.rest-client
code --install-extension rangav.vscode-thunder-client
code --install-extension ms-vscode.vscode-json
```

**Environment Testing:**

Verify the REST API tooling setup:

```sh
# Test httpie is working
http --version

# Test fx JSON processor
echo '{"test": "data"}' | fx

# Test jq JSON processor  
echo '{"test": "data"}' | jq '.test'

# Test xh (modern httpie alternative)
xh --version
```

> **Marvel API Attribution:** All Marvel API usage must include: "Data provided by Marvel. © 2025 MARVEL"

### AWS CLI & SSM Plugin

We have two AWS accounts:

> **Marvel API Attribution:** All Marvel API usage must include: "Data provided by Marvel. © 2025 MARVEL"

## AWS CLI & SSM Plugin

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

### AWS CDK

For TypeScript-based infrastructure as code:

Switch between accounts using the `--profile` flag as needed. Make sure both are set up and tested.

## AWS CDK

## Bootstrap CDK w/ aliases for our AWS accounts

cdk bootstrap --profile websites
cdk bootstrap --profile rnd

# Verify CDK installation

cdk --version

```text

**CDK Project Structure (for ultron-embeddings infrastructure):**

```

```sh

## Work from our organized Code directory

cd ~/Code/Projects

## Create CDK infrastructure for ultron-embeddings

mkdir -p ultron-embeddings/infra
cd ultron-embeddings/infra
cdk init app --language typescript

## Install additional CDK modules for S3 and Lambda

npm install @aws-cdk/aws-s3 @aws-cdk/aws-lambda @aws-cdk/aws-apigateway
```

### Vercel [https://vercel.com/]

For serverless deployment and API hosting:
npm install @aws-cdk/aws-s3 @aws-cdk/aws-lambda @aws-cdk/aws-apigateway

```sh

## Install Vercel CLI

npm install -g vercel

## Login to Vercel

vercel login

## Link project for deployment

vercel link
```

**Environment Variables for Vercel:**

```sh

## Set Marvel API credentials for Vercel deployment

# For authorized users: reference actual values from ~/Code/Projects/Marvel-API-Private/secrets/.env.marvel

vercel env add MARVEL_PUBLIC_KEY
vercel env add MARVEL_PRIVATE_KEY
```

### Terraform

For multi-cloud infrastructure management:
vercel env add MARVEL_PRIVATE_KEY

```sh

## Install Terraform

brew install terraform

## Install Terraform Language Server for VS Code

code --install-extension hashicorp.terraform

# Verify installation

terraform --version
```

**Initialize Terraform for AWS:**

```sh

## Work from an organized Code directory

cd ~/Code/Projects

## Create Terraform configuration directory

mkdir -p terraform-aws-infrastructure
cd terraform-aws-infrastructure

## Create main.tf for AWS provider

cat > main.tf << 'EOF'
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "rnd"  # or "websites"
}
EOF

## Initialize Terraform

terraform init
```