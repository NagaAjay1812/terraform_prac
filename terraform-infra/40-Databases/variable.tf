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
variable "redis_tags" {
  default = {
    project     = "roboshop"
    environment = "dev"

  }
}

variable "mysql_tags" {
  default = {
    project     = "roboshop"
    environment = "dev"

  }
}

variable "rabbitmq_tags" {
  default = {
    project     = "roboshop"
    environment = "dev"

  }
}

variable "hosted_zone_id" {
  default = "Z07326442Z8C3IRLJ3030"
}

variable "domain_name" {
  type    = string
  default = "cloudkarna.in"
}


