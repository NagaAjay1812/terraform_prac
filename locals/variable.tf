variable "instances" {
  type    = list(string)
  default = ["mongodb", "catalogue", "redis", "user", "cart", "mysql", "shipping", "rabbitmq", "payment", "frontend"]
}

variable "sg_name" {
  default = "roboshop_sg"
}
variable "sg_from_port" {
  type    = number
  default = 0
}
variable "sg_to_port" {
  type    = number
  default = 0
}
variable "sg_protocol" {
  type    = string
  default = "-1"
}
variable "sg_cidr_range" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
