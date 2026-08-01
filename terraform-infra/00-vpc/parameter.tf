resource "aws_ssm_parameter" "vpc_id" {
  name        = "/${var.project}/${var.environment}/vpc_id"
  description = "The ID of the main VPC"
  type        = "String"
  value       = module.my_vpc.vpc_id
}

# 1. Public Subnets Parameter (Stores exactly 2 subnets)
resource "aws_ssm_parameter" "public_subnets_ids" {
  name = "/${var.project}/${var.environment}/public_subnets_ids"
  type = "StringList"
  # slice(list, start_index, end_index) grabs elements 0 and 1
  value       = join(",", module.my_vpc.public_subnet_ids)
  description = "First two public subnet IDs from VPC module"
}

# 2. Private Subnets Parameter (Stores exactly 2 subnets)
resource "aws_ssm_parameter" "private_subnets_ids" {
  name        = "/${var.project}/${var.environment}/private_subnets_ids"
  type        = "StringList"
  value       = join(",", module.my_vpc.private_subnet_ids)
  description = "First two private subnet IDs from VPC module"
}

# 3. Database Subnets Parameter (Stores exactly 2 subnets)
resource "aws_ssm_parameter" "database_subnets_ids" {
  name        = "/${var.project}/${var.environment}/database_subnets_ids"
  type        = "StringList"
  value       = join(",", module.my_vpc.database_subnet_ids)
  description = "First two database subnet IDs from VPC module"
}
