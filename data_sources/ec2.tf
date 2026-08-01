resource "aws_instance" "roboshop_server" {
  count                  = length(var.instances)
  ami                    = data.aws_ami.joindevops.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.roboshop_sg.id]

  tags = {
    Name      = var.instances[count.index]
    project   = "roboshop"
    Terraform = "true"
  }
}
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
