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

# Create an EC2 Instance
resource "aws_instance" "roboshop_server" {
  count                  = length(var.instances) # instead of using fixed number ex: count = 10  we use the length() function so it dynamically calculates the number of instances based on the variable
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.roboshop_sg.id] # Attach the security group

  tags = {
    Name      = var.instances[count.index]
    project   = "Roboshop"
    terraform = "true"

  }
}
