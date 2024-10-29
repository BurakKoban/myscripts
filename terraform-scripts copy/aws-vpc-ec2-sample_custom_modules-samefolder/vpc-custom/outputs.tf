output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC id"
}

output "subnet_id" {
  value       = aws_subnet.private.id
  description = "Subnet Id"
}