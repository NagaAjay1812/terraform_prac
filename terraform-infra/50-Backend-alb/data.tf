

data "aws_ssm_parameter" "private_subnets" {
  name = "/${var.project}/${var.environment}/private_subnets_ids"
}
data "aws_ssm_parameter" "backend_alb" {
  name = "/${var.project}/${var.environment}/backend_alb_sg_id" # Replace with your SSM parameter path
}



