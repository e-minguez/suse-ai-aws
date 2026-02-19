output "instance_public_ips" {
  description = "Public IP addresses of the EC2 instances"
  value       = aws_instance.gpu_node[*].public_ip
}
