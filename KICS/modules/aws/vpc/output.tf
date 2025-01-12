output "vpc_id" {
  value = aws_vpc.this.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}

output "public_route_table_id" {
  value = aws_route_table.private.id
}

output "default_security_group_id" {
  value = aws_vpc.this.default_security_group_id
}

output "private_subnets" {
  value = aws_subnet.private.*.id
}

output "vpc_name" {
  value = aws_vpc.this.arn
}