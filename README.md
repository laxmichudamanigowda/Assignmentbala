# Deploying a Node.js App on AWS Lambda using Terraform and GitHub Actions
 
## Overview

This project contains the necessary configurations and steps to deploy a serverless Node.js application on AWS Lambda using Terraform for infrastructure as code and GitHub Actions for continuous integration and deployment (CI/CD).  


## Project Structure

```
.
├── .github                 # GitHub Actions workflow files
│   └── workflows
│       ├── build.yaml
│       └── infra.yaml
├── README.md               # This README file
├── backend                 
│   ├── Dockerfile          # Dockerfile
│   └── index.js            # A simple Node.js application
└── infra                   
    ├── environment
    │   ├── dev
    │   │   └── main.tf     # Terraform configuration file
    │   ├── prod
    │   │   └── main.tf
    │   └── staging
    │       └── main.tf
    ├── modules
    │   ├── ECR
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── IAM
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   └── LAMDA
    │       ├── main.tf
    │       ├── outputs.tf
    │       └── variables.tf
    └── providers.tf

``` 

## Prerequisites

1. Basic knowledge of Node.js, AWS, Terraform, and GitHub Actions

2. AWS Account with necessary permissions

3. AWS CLI installed and configured

4. Terraform installed on the system

5. GitHub repository with GitHub Actions secrets configured for AWS access
    - `AWS_ACCESS_KEY_ID`
    - `AWS_SECRET_ACCESS_KEY`
    - `AWS_ACCOUNT_ID`

## GitHub Actions Workflows

The GitHub Actions workflows are defined in the `.github/workflows/` path:

### 1. `infra.yaml`: Infrastructure Provisioning

This workflow provisions the AWS infrastructure using Terraform. 

#### Triggers:

- On `push` and `pull_request` events to the main branch.       

- Manually triggered via `workflow_dispatch`.

#### Steps:

1. Checkout the code.

2. Set up Terraform and AWS credentials.

3. Run `TFLint` for Terraform linting.

4. Execute Terraform commands:

    - `terraform init`

    - `terraform validate`

    - `terraform plan`

    - `terraform apply` (only on `push` to `main` branch).

### 2. `build.yaml`: Build, Push, and Deploy to AWS Lambda

This workflow builds a Docker image, pushes it to Amazon ECR, and updates AWS Lambda.

#### Triggers:

- Runs automatically after successful completion of `infra.yaml`.

- Manually triggered via `workflow_dispatch`.

#### Steps:

1. Checkout the code.

2. Set up Docker and AWS credentials.

3. Log in to Amazon ECR.

4. Build, tag, and push a Docker image to ECR.

5. Deploy the updated image to AWS Lambda.

6. Cleanup local Docker images.

## How to Run

### Provision Infrastructure

To manually trigger infrastructure provisioning:

1. Navigate to **GitHub Actions**.

2. Select the **Infra Provisioning through Terraform** workflow.

3. Click **Run workflow** and choose an environment (dev, staging, prod).

### Build and Deploy

This runs automatically after successful infrastructure provisioning. However, it can also be triggered manually from GitHub Actions under the Build, Push a Docker Image to ECR, and Deploy it to AWS Lambda workflow.

## Troubleshooting

If you encounter issues during deployment, consider the following:

- Verify AWS IAM roles and permissions.

- Check GitHub Actions logs for workflow errors.

- Ensure Terraform is correctly initialized and applied.

- Confirm Docker images are pushed to the correct ECR repository.
 
## Collaboration

Please feel free to submit a pull request or open an issue for any suggestions or improvements.

### Happy Coding! 🚀


