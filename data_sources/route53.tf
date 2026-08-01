#private IP
resource "aws_route53_record" "roboshop_r53" {
  count   = length(aws_instance.roboshop_server)
  zone_id = data.aws_route53_zone.primary.zone_id

  name            = "${var.instances[count.index]}.${var.domain_name}" #dynamodb.cloudkarna.in
  type            = "A"
  ttl             = 1
  records         = [aws_instance.roboshop_server[count.index].private_ip]
  allow_overwrite = true
}

# public IP
resource "aws_route53_record" "roboshop_frontend_r53" {
  count           = length(aws_instance.roboshop_server)
  zone_id         = data.aws_route53_zone.primary.zone_id
  name            = "roboshop.${var.domain_name}" #roboshop.cloudkarna.in
  type            = "A"
  ttl             = 1
  records         = [aws_instance.roboshop_server[index(var.instances, "frontend")].public_ip]
  allow_overwrite = true
}
