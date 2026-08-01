module "test_vpc" {
  source      = "../terraform-aws-vpc"
  project     = "roboshop"
  environment = "dev"
}
