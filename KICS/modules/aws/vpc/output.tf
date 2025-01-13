output "vpc_id" {
  value       = aws_vpc.this.id
  description = "The ID of the created VPC."
}

output "private_route_table_id" {
  value       = aws_route_table.private.id
  description = "The ID of the private route table."
}

output "public_route_table_id" {
  value       = aws_route_table.public.id
  description = "The ID of the public route table."
}

output "default_security_group_id" {
  value       = aws_vpc.this.default_security_group_id
  description = "The ID of the default security group for the VPC."
}

output "private_subnets" {
  value       = aws_subnet.private.*.id
  description = "The IDs of the private subnets in the VPC."
}

output "vpc_name" {
  value       = aws_vpc.this.arn
  description = "The ARN of the created VPC."
}