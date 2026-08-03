locals {
  ami_id               = data.aws_ami.joindevops.id
  database_subnet_list = split(",", data.aws_ssm_parameter.database_subnets.value)

  # Grabs index 0, which corresponds to your first subnet (us-east-1a)
  subnet_useast1a_id = local.database_subnet_list[0]

  mongodb_sg_id = data.aws_ssm_parameter.mongodb.value
  Name          = "${var.project}-${var.environment}-mongodb"
  common_tags = {
    project   = "roboshop"
    Terraform = "true"
  }

  mongodb_final_tags = merge(local.common_tags, var.mongodb_tags)
}

