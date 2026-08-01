variable "instances" {
  type = map(any)
  default = {
    "mongodb"   = "t3.micro",
    "catalogue" = "t3.small",
    "redis"     = "t3.micro",
    "user"      = "t3.micro",
    "frontend"  = "t3.micro"
  }
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
