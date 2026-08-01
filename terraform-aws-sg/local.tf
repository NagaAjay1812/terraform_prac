locals {
  Name = "${var.project}-${var.environment}"
  common_tags = {
    project     = var.project
    environment = var.environment
    Terraform   = "true"
  }
  sg_final_tags = merge(local.common_tags, var.sg_tags)

}


