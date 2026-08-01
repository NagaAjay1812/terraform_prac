locals {
  ami_id             = data.aws_ami.joindevops.id
  public_subnet_list = split(",", data.aws_ssm_parameter.public_subnets.value)

  # Grabs index 0, which corresponds to your first subnet (us-east-1a)
  subnet_useast1a_id = local.public_subnet_list[0]

  bastion_sg_id = data.aws_ssm_parameter.bastion.value
  Name          = "${var.project}-${var.environment}-bastion"
  common_tags = {
    project   = "roboshop"
    Terraform = "true"
  }

  bastion_final_tags = merge(local.common_tags, var.bastion_tags)
}

