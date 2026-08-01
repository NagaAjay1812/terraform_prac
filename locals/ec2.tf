
resource "aws_instance" "roboshop_server" {
  count                  = length(var.instances)
  ami                    = data.aws_ami.joindevops.id
  instance_type          = local.instance_type
  vpc_security_group_ids = [aws_security_group.roboshop_sg.id]

  tags = merge(local.ec2_final_tags, {
    Name = local.instance_names[count.index]
  })
}

resource "aws_security_group" "roboshop_sg" {
  name = var.sg_name
  ingress {
    from_port   = var.sg_from_port
    to_port     = var.sg_to_port
    protocol    = var.sg_protocol
    cidr_blocks = var.sg_cidr_range
  }
  egress {
    from_port   = var.sg_from_port
    to_port     = var.sg_to_port
    protocol    = var.sg_protocol
    cidr_blocks = var.sg_cidr_range
  }
  tags = local.sg_final_tags
}
