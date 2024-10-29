output "private_ip" {
  value       = module.ec2-instance.private_ip
  description = "EC2 private IP"
}

output "private_dns" {
  value       = module.ec2-instance.private_dns
  description = "EC2 DNS"
}
