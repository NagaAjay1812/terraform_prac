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

data "aws_ssm_parameter" "private_subnets" {
  name = "/${var.project}/${var.environment}/private_subnets_ids"
}
data "aws_ssm_parameter" "catalogue" {
  name = "/${var.project}/${var.environment}/catalogue_sg_id" # Replace with your SSM parameter path
}



