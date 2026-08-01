# 1. Create the Bastion EC2 Instance
resource "aws_instance" "bastion" {
  ami           = local.ami_id
  instance_type = var.inst_type

  # Uses the Subnet ID fetched from your SSM Parameter Store
  subnet_id = local.subnet_useast1a_id

  # Uses your existing Bastion Security Group ID local
  vpc_security_group_ids = [local.bastion_sg_id]

  # Assigns a public IP address so you can access it over the internet
  associate_public_ip_address = true

  # Connects the IAM Instance Profile to this EC2 instance
  iam_instance_profile = aws_iam_instance_profile.bastion_profile.name

  user_data = file("bastion.sh")
  # Configures the root EBS storage volume
  root_block_device {
    volume_size           = 50    # Sets size to exactly 50 GB
    volume_type           = "gp3" # Uses modern, cost-efficient gp3 storage
    encrypted             = true  # Encrypts the volume at rest (Best Practice)
    delete_on_termination = true  # Cleans up storage automatically if instance is deleted
  }
  tags = merge(local.bastion_final_tags,
    {
      Name = "${var.project}-${var.environment}-bastion"
    }

  )

}

# 2. Create the IAM Role and define its Trust Policy (Allows EC2 to assume it)
resource "aws_iam_role" "bastion_role" {
  name = "${var.project}-${var.environment}-bastion-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach Full Administration Access to the Bastion Role
resource "aws_iam_role_policy_attachment" "bastion_admin" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# 3. Create the IAM Instance Profile (This is what EC2 actually uses)
resource "aws_iam_instance_profile" "bastion_profile" {
  name = "${var.project}-${var.environment}-bastion-profile"
  role = aws_iam_role.bastion_role.name
}

