data "aws_ami" "joindevops" {

  owners = ["973714476881"]

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice*"]
  }

  filter {
    name   = "image-id"
    values = ["ami-0220d79f3f480ecf5"]
  }
}
