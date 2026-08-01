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
  default = "roboshop_sg"
}

variable "sg_from_port" {
  default = 0
}
variable "sg_to_port" {
  default = 0
}
