# 1) MongoDB: step:1 Create the catalogue EC2 Instance in database subnet
resource "aws_instance" "catalogue" {
  ami           = local.ami_id
  instance_type = var.inst_type

  # Uses the Subnet ID fetched from your SSM Parameter Store
  subnet_id = local.subnet_useast1a_id

  # Uses your existing Bastion Security Group ID local
  vpc_security_group_ids = [local.catalogue_sg_id]

  tags = merge(local.catalogue_final_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue"
    }
  )
}
# step:2. Trigger file copy and execution when Instance ID changes
resource "terraform_data" "bootstrap_catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]

  # Connection details for both provisioners
  connection {
    type     = "ssh"
    user     = "ec2-user" # Change to "ubuntu" if using Ubuntu AMI
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip # Use .private_ip if inside a private VPC
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
      "sudo sh /tmp/bootstrap.sh catalogue ${var.environment}"
    ]
  }
}


# 2): Stop the instance after Ansible configuration finishes
resource "aws_ec2_instance_state" "stop_catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"

  depends_on = [
    terraform_data.bootstrap_catalogue
  ]
}

# # 3): Create the Catalogue AMI after the instance stops
# resource "aws_ami_from_instance" "catalogue" {
#   name               = "${var.project}-${var.environment}-catalogue-${aws_instance.catalogue.id}"
#   source_instance_id = aws_instance.catalogue.id

#   # The instance was already stopped in Step 3.
#   snapshot_without_reboot = true

#   depends_on = [
#     aws_ec2_instance_state.stop_catalogue
#   ]

#   tags = merge(
#     local.catalogue_final_tags,
#     {
#       Name = "${var.project}-${var.environment}-catalogue-ami"
#     }
#   )
# }
