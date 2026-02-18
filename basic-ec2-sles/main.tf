provider "aws" {
  region = var.region
}

data "aws_ami" "sles" {
  most_recent = true

  filter {
    name   = "name"
    values = ["suse-sles-15-sp7-byos-*"]
  }
  # pint.suse.com -> list of amis
  # aws ec2 describe-images --image-ids ami-02baff494c9fc481a --region eu-central-1 | jq -r ".Images[0].OwnerId"
  owners = ["679593333241"]
}

resource "aws_key_pair" "deployer" {
  key_name   = "${var.project_name}-deployer-key"
  public_key = file(var.ssh_public_key_path)

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-deployer-key"
  })
}

resource "aws_instance" "app_server" {
  ami                         = data.aws_ami.sles.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.deployer.key_name

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = var.root_volume_delete_on_termination
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-app-server"
  })
}
