variable "project" {
  default = "roboshop"
}
variable "environment" {
  default = "dev"
}
variable "inst_type" {
  default = "t3.micro"
}
variable "mongodb_tags" {
  default = {
    project     = "roboshop"
    environment = "dev"

  }
}


