## private IP
resource "aws_route53_record" "roboshop_r53" {
  count   = length(aws_instance.roboshop_server)
  zone_id = var.hosted_zone_id

  # Generates: ://yourdomain.com, ://yourdomain.com, etc.
  name = "${var.instances[count.index]}.${var.domain_name}" #dynamodb.cloudkarna.in

  type = "A"
  ttl  = 1

  # Automatically grabs the Private IP of each corresponding instance
  records         = [aws_instance.roboshop_server[count.index].private_ip]
  allow_overwrite = true
}

#public Ip
resource "aws_route53_record" "roboshop_frontend_r53" {
  count   = length(aws_instance.roboshop_server)
  zone_id = var.hosted_zone_id

  # Generates: ://yourdomain.com, ://yourdomain.com, etc.
  name = "roboshop.${var.domain_name}" #roboshop.cloudkarna.in

  type = "A"
  ttl  = 1

  # Automatically grabs the Private IP of each corresponding instance
  records         = [aws_instance.roboshop_server[index(var.instances, "frontend")].public_ip] #index(list, value) you know list = var.instances & value = frontend ].public_ip]
  allow_overwrite = true
}


