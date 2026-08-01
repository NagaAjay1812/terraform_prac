output "ec2_info" {
  value = aws_instance.roboshop_server
}

output "aws_ami" {
  value = data.aws_ami.joindevops.id
}