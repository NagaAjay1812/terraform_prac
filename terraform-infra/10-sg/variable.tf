variable "project" {
  default = "roboshop"
}
variable "environment" {
  default = "dev"
}

variable "sg_names" {
  default = [
    #databases
    "mongodb", "redis", "mysql", "rabbitmq",
    #private/ backend
    "catalogue", "cart", "user", "payment", "shipping",
    # Backend ALB
    "backend_alb",
    #public/frontend
    "frontend",
    # frontend ALB
    "frontend_alb",
    #Bastion
    "bastion"
  ]

}
variable "sg_tags" {
  default = {}
}


