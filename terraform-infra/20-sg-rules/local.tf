locals {
  bastion_sg_id   = data.aws_ssm_parameter.bastion.value
  mongodb_sg_id   = data.aws_ssm_parameter.mongodb.value
  catalogue_sg_id = data.aws_ssm_parameter.catalogue.value
  user_sg_id      = data.aws_ssm_parameter.user.value
  redis_sg_id     = data.aws_ssm_parameter.redis.value
  mysql_sg_id     = data.aws_ssm_parameter.mysql.value
  rabbitmq_sg_id  = data.aws_ssm_parameter.rabbitmq.value
}
