# Basic EC2 SLES Deployment with Terraform

This project deploys a basic SUSE Linux Enterprise Server (SLES) instance on AWS within a dedicated VPC, including all necessary networking components and security groups.

## Features

-   **Modular Structure**: Networking, security, and compute resources are separated into different files.
-   **Dynamic Naming**: All resources are named based on a `project_name` variable.
-   **Common Tagging**: A standard set of tags is applied to all created resources.
-   **Secure Access**: Automatically creates an AWS Key Pair from your local SSH public key and allows SSH ingress.

## Prerequisites

-   [Terraform](https://www.terraform.io/downloads.html) (>= 1.2)
-   AWS CLI configured with appropriate credentials.
-   An existing SSH key pair on your host.

## File Structure

-   `main.tf`: Provider configuration, AMI data source, and EC2 instance.
-   `vpc.tf`: VPC, Subnet, Internet Gateway, and Route Tables.
-   `security_groups.tf`: Security group allowing SSH (port 22).
-   `variables.tf`: Input variables for customization.
-   `outputs.tf`: Outputs like the instance's public IP.

## Usage

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Specify your SSH Public Key

You must provide the path to your SSH public key file. The easiest way is via an environment variable:

```bash
export TF_VAR_ssh_public_key_path="~/.ssh/id_rsa.pub"
```

Alternatively, you can create a `terraform.tfvars` file:

```hcl
ssh_public_key_path = "~/.ssh/id_rsa.pub"
project_name        = "my-suse-project"
```

### 3. Deploy

```bash
terraform apply
```

### 4. Connect

Once the deployment is complete, Terraform will output the public IP. Connect using:

```bash
ssh -i /path/to/your/private_key ec2-user@<instance_public_ip>
```

## Cleanup

To remove all resources created by this project and avoid ongoing AWS costs, run:

```bash
terraform destroy
```

> **Note**: You may need to provide the same variables (like `ssh_public_key_path`) used during `apply` so Terraform can successfully refresh the state before destroying.

## Variables

| Name | Description | Default |
| :--- | :--- | :--- |
| `project_name` | Prefix for resource names | `edu` |
| `region` | AWS region | `eu-central-1` |
| `ssh_public_key_path` | Path to your `.pub` file | (Required) |
| `instance_type` | EC2 instance size | `t2.micro` |
| `common_tags` | Map of tags for all resources | `{ Environment = "dev", ... }` |
