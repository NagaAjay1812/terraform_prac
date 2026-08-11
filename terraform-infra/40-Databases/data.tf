data "aws_ami" "joindevops" {
  owners = ["973714476881"]

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice*"] # Added wildcard * for safety
  }
  filter {
    name   = "image-id"
    values = ["ami-0220d79f3f480ecf5"]
  }

}

data "aws_ssm_parameter" "database_subnets" {
  name = "/${var.project}/${var.environment}/database_subnets_ids"
}
data "aws_ssm_parameter" "mongodb" {
  name = "/${var.project}/${var.environment}/mongodb_sg_id" # Replace with your SSM parameter path
}
data "aws_ssm_parameter" "redis" {
  name = "/${var.project}/${var.environment}/redis_sg_id" # Replace with your SSM parameter path
}

data "aws_ssm_paramter" "mysql" {
  name = "/${var.project}/${var.environment}/mysql_sg_id"
}
data "aws_ssm_paramter" "rabbitmq" {
  name = "/${var.project}/${var.environment}/rabbitmq_sg_id"
}

