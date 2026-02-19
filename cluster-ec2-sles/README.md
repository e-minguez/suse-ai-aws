# Cluster EC2 SLES Deployment for GPUDirect RDMA/EFA Testing with Terraform or OpenTofu

> **Disclaimer**: This is a personal project and is NOT an official SUSE or AWS repository. The content and code provided here are for educational and testing purposes, and are not officially supported.

This project deploys two SUSE Linux Enterprise Server (SLES) instances in a **Cluster Placement Group** within the same subnet and Availability Zone on AWS. This setup is optimized for low-latency network performance between instances, specifically intended for testing **GPUDirect RDMA** with **AWS EFA**. This module is compatible with both Terraform and OpenTofu.

## Features

-   **Cluster Placement Group**: Ensures instances are physically located close to each other for high-performance networking.
-   **GPU Nodes**: Deploys 2 `gpu-node` instances by default.
-   **Self-Referencing Security Group**: Allows all traffic between the instances in the cluster.
-   **Modern Instance Type**: Defaults to `g7e.12xlarge` (NVIDIA Blackwell).
-   **Modular Structure**: Networking, security, and compute resources are separated into different files.
-   **Dynamic Naming**: All resources are named based on a `project_name` variable.

## Prerequisites

-   [OpenTofu](https://opentofu.org/docs/intro/install/) (>= 1.6) or [Terraform](https://www.terraform.io/downloads.html) (>= 1.2)
-   AWS CLI configured with appropriate credentials.
-   An existing SSH key pair on your host.

## File Structure

-   `main.tf`: Provider configuration, AMI data source, Placement Group, and EC2 instances.
-   `vpc.tf`: VPC, Subnet, Internet Gateway, and Route Tables.
-   `security_groups.tf`: Security group allowing SSH and all internal traffic.
-   `variables.tf`: Input variables for customization.
-   `outputs.tf`: Outputs like the instances' public IPs.
-   `terraform.tf`: Terraform and provider version constraints.

## Usage

### 1. Initialize

```bash
tofu init # or terraform init
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
tofu apply # or terraform apply
```

### 4. Connect

Once the deployment is complete, the tool will output the public IPs. Connect to either instance using:

```bash
ssh -i /path/to/your/private_key ec2-user@<instance_public_ip>
```

## Cleanup

To remove all resources created by this project and avoid ongoing AWS costs, run:

```bash
tofu destroy # or terraform destroy
```

## Variables

| Name | Description | Default |
| :--- | :--- | :--- |
| `project_name` | Prefix for resource names | `edu` |
| `region` | AWS region | `eu-central-1` |
| `ssh_public_key_path` | Path to your `.pub` file | (Required) |
| `instance_type` | EC2 instance size | `g7e.12xlarge` |
| `root_volume_size` | Size of the root volume in GB | `100` |
| `common_tags` | Map of tags for all resources | `{ Environment = "dev", ... }` |
