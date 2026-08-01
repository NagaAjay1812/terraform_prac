variable "instances" {
  type    = list(string)
  default = ["mongodb", "catalogue", "redis", "user", "cart", "mysql", "shipping", "rabbitmq", "payment", "frontend"]
}

variable "hosted_zone_id" {
  default = "Z07326442Z8C3IRLJ3030"
}
variable "domain_name" {
  default = "cloudkarna.in"
}

variable "ami_id" {
  type    = string
  default = "ami-0220d79f3f480ecf5"
}
variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "sg_name" {
  type    = string
  default = "allow_all_roboshop"
}

variable "sg_from_port" {
  default = 0
}
variable "sg_to_port" {
  default = 0
}
