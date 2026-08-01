variable "project" {
  default = "roboshop"
}
variable "environment" {
  default = "dev"
}
variable "inst_type" {
  default = "t3.micro"
}
variable "bastion_tags" {
  default = {
    project     = "roboshop"
    environment = "dev"

  }
}


