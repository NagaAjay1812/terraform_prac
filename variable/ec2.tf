# Create a Security Group
resource "aws_security_group" "roboshop_sg" {
  name        = var.sg_name
  description = "Allow SSH and HTTP inbound traffic"

  # Inbound rules
  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = var.sg_from_port
    to_port     = var.sg_to_port
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH from anywhere"
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
    Name = "roboshop-sg"
  }
}

# Create an EC2 Instance
resource "aws_instance" "roboshop_server"{
  ami  = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.roboshop_sg.id]

  tags = {
    Name  = "roboshop"
    Terrafom = "true"
  }


}


# create security group
# resource "aws_security_group" "security_gp" {
#   name  = var.security_gp

# # Ingress rules
#   ingress{
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#    ingress{
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

# # egress rules
#   egress{
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     name = var.sg_tags
#   }
#   }

