resource "aws_instance" "roboshop_server" {
  count                  = length(var.inst_names)
  ami                    = local.ami_id
  instance_type          = var.instance_type
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
    cidr_blocks = var.sg_cidr_blocks
  }
  ingress {
    from_port   = var.sg_from_port
    to_port     = var.sg_to_port
    protocol    = var.sg_protocol
    cidr_blocks = var.sg_cidr_blocks
  }
  egress {
    from_port   = var.sg_from_port
    to_port     = var.sg_to_port
    protocol    = var.sg_protocol
    cidr_blocks = var.sg_cidr_blocks
  }
  tags = local.sg_final_tags
}
