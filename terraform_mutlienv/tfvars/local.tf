locals {
  instance_names = var.inst_names
  environment    = var.environment
  ami_id         = data.aws_ami.joindevops.id

  common_tags = {
    project   = "roboshop"
    terraform = "true"
  }
  ec2_tags = {

    project   = "roboshop"
    terraform = "true"

  }

  ec2_final_tags = merge(local.common_tags, local.ec2_tags)



  sg_tags = {
    Name      = var.sg_name
    project   = "roboshop"
    terraform = "true"

  }

  sg_final_tags = merge(local.common_tags, local.sg_tags)
}
