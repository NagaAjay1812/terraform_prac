locals {
  ami_id              = data.aws_ami.joindevops.id
  private_subnet_list = split(",", data.aws_ssm_parameter.private_subnets.value)

  # Grabs index 0, which corresponds to your first subnet (us-east-1a)
  subnet_useast1a_id = local.private_subnet_list[0]

  catalogue_sg_id = data.aws_ssm_parameter.catalogue.value


  common_tags = {
    project   = "roboshop"
    Terraform = "true"
  }

  catalogue_final_tags = merge(local.common_tags, var.catalogue_tags)

}

