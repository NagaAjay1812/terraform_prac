variable "project" {

}
variable "environment" {

}

variable "cidr_block" {
  default = "10.0.0.0/16"
}
variable "vpc_tags" {
  type    = map(string)
  default = {}
}

# --- PUBLIC SUBNETS VARIABLES ---
variable "public_cidr_blocks" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "pub_avai_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

# --- PRIVATE SUBNETS VARIABLES ---
variable "private_cidr_blocks" {
  type    = list(string)
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "private_avai_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

# --- DATABASE SUBNETS VARIABLES ---
variable "database_cidr_blocks" {
  type    = list(string)
  default = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "database_avai_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}
