variable "project_name" {
  description = "The name of the project, used for resource naming"
  type        = string
  default     = "edu"
}

variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "terraform-aws-ai"
  }
}

variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "The availability zone for the subnet"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "g7e.12xlarge"
}

variable "root_volume_size" {
  description = "The size of the root volume in GB"
  type        = number
  default     = 100
}

variable "root_volume_type" {
  description = "The type of the root volume (e.g., gp3, gp2, io1)"
  type        = string
  default     = "gp3"
}

variable "root_volume_delete_on_termination" {
  description = "Whether the root volume should be deleted when the instance is terminated"
  type        = bool
  default     = true
}

variable "ssh_public_key_path" {
  description = "The path to the SSH public key file (e.g., ~/.ssh/id_rsa.pub)"
  type        = string
}
