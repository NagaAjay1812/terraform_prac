resource "aws_lb" "backend_alb" {
  name               = "Roboshop-infra"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.backend_alb_sg_id]
  subnets            = local.private_subnet_list

  #we are set this as false because if we set to true we cant delete through terraform
  enable_deletion_protection = false

  tags = merge(
    {
      Name = "${var.project}-${var.environment}-backend-alb"
    },
    local.common_tags
  )
}

resource "aws_lb_listener" "backend_alb_listener" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hi,this is the backend ALB</h1>"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "backend_alb" {
  zone_id = var.hosted_zone_id
  name    = "*.backend-alb-${var.environment}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.backend_alb.dns_name # Updated to match your resource name
    zone_id                = aws_lb.backend_alb.zone_id  # Updated to match your resource name
    evaluate_target_health = true
  }
}
