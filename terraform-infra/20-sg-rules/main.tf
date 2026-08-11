# Rule 1: Internet to Bastion
resource "aws_security_group_rule" "bastion_internet" {
  type        = "ingress"
  description = "Allow inbound SSH traffic from Internet"

  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  # Target SG ID
  security_group_id = local.bastion_sg_id
}

# Rule 2: Bastion to MongoDB
resource "aws_security_group_rule" "mongodb_from_bastion" {
  type        = "ingress"
  description = "Allow inbound SSH traffic from bastion"

  from_port = 22
  to_port   = 22
  protocol  = "tcp"

  # Source and Target SG connections
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.mongodb_sg_id
}
# Rule 3: Bastion to Redis
resource "aws_security_group_rule" "redis_from_bastion" {
  type        = "ingress"
  description = "Allow inbound SSH traffic from bastion"

  from_port = 22
  to_port   = 22
  protocol  = "tcp"

  # Source and Target SG connections
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.redis_sg_id
}
# Rule 4: Bastion to MySQL
resource "aws_security_group_rule" "mysql_from_bastion" {
  type        = "ingress"
  description = "Allow inbound SSH traffic from bastion"

  from_port = 22
  to_port   = 22
  protocol  = "tcp"

  # Source and Target SG connections
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.mysql_sg_id
}
# Rule 5: Bastion to Rabbitmq
resource "aws_security_group_rule" "rabbitmq_from_bastion" {
  type        = "ingress"
  description = "Allow inbound SSH traffic from bastion"

  from_port = 22
  to_port   = 22
  protocol  = "tcp"

  # Source and Target SG connections
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.rabbitmq_sg_id
}

# Rule 6: MongoDB to Catalogue
resource "aws_security_group_rule" "mongodb_from_catalogue" {
  type        = "ingress"
  description = "Allow inbound custom tcp traffic from catalogue"

  from_port = 27017
  to_port   = 27017
  protocol  = "tcp"

  # Source and Target SG connections
  source_security_group_id = local.catalogue_sg_id
  security_group_id        = local.mongodb_sg_id
}

# Rule 7: MongoDB to User
resource "aws_security_group_rule" "mongodb_from_user" {
  type        = "ingress"
  description = "Allow inbound custom tcp traffic from user"

  from_port = 27017
  to_port   = 27017
  protocol  = "tcp"

  # Source and Target SG connections
  source_security_group_id = local.user_sg_id
  security_group_id        = local.mongodb_sg_id
}
