output "az_info" {
  value = data.aws_availability_zones.available
}
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "igw_id" {
  description = "The ID of the Internet Gateway attached to the VPC"
  value       = aws_internet_gateway.igw.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}
output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  description = "List of IDs of database subnets"
  value       = aws_subnet.database[*].id
}

output "public_route_table_id" {
  description = "The ID of the Roboshop public route table"
  value       = aws_route_table.public_rt.id
}

output "private_route_table_id" {
  description = "The ID of the Roboshop private route table"
  value       = aws_route_table.private_rt.id
}

output "database_route_table_id" {
  description = "The ID of the Roboshop database route table"
  value       = aws_route_table.database_rt.id
}

output "nat_gateway_id" {
  description = "The ID of the Roboshop NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

