output "instance_info" {
  value = aws_instance.roboshop_server
}

output "ami_info" {
  value = data.aws_ami.joindevops.id
}

# output "domain_name" {
#   value = data.aws_route53_zone.primary.name
# }

output "zone_id" {
  value = data.aws_route53_zone.primary.id
}
