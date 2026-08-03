# 1)step:1 Create the mongoDB EC2 Instance in database subnet
resource "aws_instance" "mongoDB" {
  ami           = local.ami_id
  instance_type = var.inst_type

  # Uses the Subnet ID fetched from your SSM Parameter Store
  subnet_id = local.subnet_useast1a_id

  # Uses your existing Bastion Security Group ID local
  vpc_security_group_ids = [local.mongodb_sg_id]

  tags = merge(local.mongodb_final_tags,
    {
      Name = "${var.project}-${var.environment}-mongodb"
    }
  )
}
# step:2. Trigger file copy and execution when Instance ID changes
resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongoDB.id
  ]

  # Connection details for both provisioners
  connection {
    type     = "ssh"
    user     = "ec2-user" # Change to "ubuntu" if using Ubuntu AMI
    password = "DevOps321"
    host     = aws_instance.mongoDB.private_ip # Use .private_ip if inside a private VPC
  }

  # STEP 3: Copy bootstrap.sh from your local computer to the EC2 instance
  provisioner "file" {
    source      = "bootstrap.sh"      # Local path to your script
    destination = "/tmp/bootstrap.sh" # Remote destination path
  }

  # STEP 4: Make the script executable and execute it via remote-exec
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}"
    ]
  }
}

# # 2) step: 1 Create the redis EC2 Instance in database subnet
# resource "aws_instance" "redis" {
#   ami           = local.ami_id
#   instance_type = var.inst_type

#   # Uses the Subnet ID fetched from your SSM Parameter Store
#   subnet_id = local.subnet_useast1a_id

#   # Uses your existing Bastion Security Group ID local
#   vpc_security_group_ids = [local.redis_sg_id]

#   tags = merge(local.mongodb_final_tags,
#     {
#       Name = "${var.project}-${var.environment}-mongodb"
#     }
#   )
# }
# # 2. Trigger file copy and execution when Instance ID changes
# resource "terraform_data" "mongodb" {
#   triggers_replace = [
#     aws_instance.mongodb.id
#   ]

#   # Connection details for both provisioners
#   connection {
#     type     = "ssh"
#     user     = "ec2-user" # Change to "ubuntu" if using Ubuntu AMI
#     password = "DevOps321"
#     host     = aws_instance.mongodb.private_ip # Use .private_ip if inside a private VPC
#   }

#   # STEP 1: Copy bootstrap.sh from your local computer to the EC2 instance
#   provisioner "file" {
#     source      = "bootstrap.sh"      # Local path to your script
#     destination = "/tmp/bootstrap.sh" # Remote destination path
#   }

#   # STEP 2: Make the script executable and execute it via remote-exec
#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/bootstrap.sh",
#       "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}"
#     ]
#   }
# }







