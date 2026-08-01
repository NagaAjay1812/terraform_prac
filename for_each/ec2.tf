# Create a Security Group
resource "aws_security_group" "roboshop_sg" {
  name = var.sg_name # this is for AWS account

  description = "Allow TLS inbound traffic"

  # Inbound rules
  ingress {
    from_port   = var.sg_from_port
    to_port     = var.sg_to_port
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.sg_from_port
    to_port     = var.sg_to_port
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rules (allows all outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_all_roboshop"
  }
}

#for_each
# Create an EC2 Instance
resource "aws_instance" "roboshop_server" {
  for_each               = var.instances
  ami                    = var.ami_id
  instance_type          = each.value
  vpc_security_group_ids = [aws_security_group.roboshop_sg.id] # Attach the security group

  tags = {
    Name      = each.key
    project   = "Roboshop"
    terraform = "true"

  }
}
