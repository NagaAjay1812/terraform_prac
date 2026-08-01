locals {
  instance_names = var.instances
  instance_type  = "t3.micro"

  ec2_tags = {
    project   = "roboshop"
    terraform = "true"
  }

  common_tags = {
    project   = "roboshop"
    terraform = "true"
    env       = "dev"
  }

  ec2_final_tags = merge(local.common_tags, local.ec2_tags)

  sg_tags = {
    name      = var.sg_name
    project   = "roboshop"
    terraform = "true"
  }
  sg_final_tags = merge(local.common_tags, local.sg_tags)
}
