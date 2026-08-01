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
resource "aws_instance" "roboshop_server" {
  ami                    = var.ami_id
  instance_type          = var.environment == "dev" ? "t3.micro" : "t3.small"
  vpc_security_group_ids = [aws_security_group.roboshop_sg.id] # Attach the security group

  tags = {
    Name      = "Roboshop"
    terraform = true

  }
}



# resource "aws_instance" "roboshop"{
#     ami = var.ami_id
#     instance_type = var.instance_type
#     vpc_security_group_id = [aws_security_group.sec_gp.id]
#     tags = {
#         Name = "roboshop"
#         project = roboshop
#         Terrfaorm = true
#     }
# }
