## private IP
resource "aws_route53_record" "roboshop_r53" {
  for_each = aws_instance.roboshop_server

  zone_id = var.hosted_zone_id

  # Generates: ://yourdomain.com, ://yourdomain.com, etc.
  name = "${each.key}.${var.domain_name}" #dynamodb.cloudkarna.in

  type = "A"
  ttl  = 1

  # Automatically grabs the Private IP of each corresponding instance
  records         = [each.value.private_ip]
  allow_overwrite = true
}

#public Ip
resource "aws_route53_record" "roboshop_frontend_r53" {
  for_each = aws_instance.roboshop_server
  zone_id  = var.hosted_zone_id

  # Generates: ://yourdomain.com, ://yourdomain.com, etc.
  name = "roboshop.${var.domain_name}" #roboshop.cloudkarna.in

  type = "A"
  ttl  = 1

  # Automatically grabs the Private IP of each corresponding instance
  records         = [lookup(aws_instance.roboshop_server, "frontend").public_ip]
  allow_overwrite = true
}


