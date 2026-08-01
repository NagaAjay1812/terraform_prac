output "azs_info" {
  value = module.vpc.azs_info # module developer giving outputs we need to catch
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.test_vpc.vpc_id
}


output "internet_gateway_id" {
  description = "The ID of the Internet Gateway attached to the VPC"
  value       = module.test_vpc.igw_id
}

output "public_subnet_ids" {
  description = "The IDs of the Roboshop public subnets"
  value       = module.test_vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The IDs of the Roboshop private subnets"
  value       = module.test_vpc.private_subnet_ids
}

output "database_subnet_ids" {
  description = "The IDs of the Roboshop database subnets"
  value       = module.test_vpc.database_subnet_ids
}
