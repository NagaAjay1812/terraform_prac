output "vpc_id" {
  value = module.my_vpc.vpc_id
}

output "public_sub_id" {
  value = module.my_vpc.public_subnet_ids
}
output "private_sub_id" {
  value = module.my_vpc.private_subnet_ids
}
output "database_sub_id" {
  value = module.my_vpc.database_subnet_ids
}



