locals {

  private_subnet_list = split(",", data.aws_ssm_parameter.private_subnets.value)

  backend_alb_sg_id = data.aws_ssm_parameter.backend_alb.value


  common_tags = {
    project   = "roboshop"
    Terraform = "true"
  }



}

