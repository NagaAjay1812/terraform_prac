# 1) MongoDB: step:1 Create the mongoDB EC2 Instance in database subnet
resource "aws_instance" "mongodb" {
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
resource "terraform_data" "bootstrap_mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]

  # Connection details for both provisioners
  connection {
    type     = "ssh"
    user     = "ec2-user" # Change to "ubuntu" if using Ubuntu AMI
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip # Use .private_ip if inside a private VPC
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
# 2) Redis: step:1 Create the redis EC2 Instance in database subnet
resource "aws_instance" "redis" {
  ami           = local.ami_id
  instance_type = var.inst_type

  # Uses the Subnet ID fetched from your SSM Parameter Store
  subnet_id = local.subnet_useast1a_id

  # Uses your existing Bastion Security Group ID local
  vpc_security_group_ids = [local.redis_sg_id]

  tags = merge(local.redis_final_tags,
    {
      Name = "${var.project}-${var.environment}-redis"
    }
  )
}
# step:2. Trigger file copy and execution when Instance ID changes
resource "terraform_data" "bootstrap_redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]

  # Connection details for both provisioners
  connection {
    type     = "ssh"
    user     = "ec2-user" # Change to "ubuntu" if using Ubuntu AMI
    password = "DevOps321"
    host     = aws_instance.redis.private_ip # Use .private_ip if inside a private VPC
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
      "sudo sh /tmp/bootstrap.sh redis ${var.environment}"
    ]
  }
}

# 3) Mysql: step:1 Create the redis EC2 Instance in database subnet
resource "aws_instance" "mysql" {
  ami           = local.ami_id
  instance_type = var.inst_type

  # Uses the Subnet ID fetched from your SSM Parameter Store
  subnet_id = local.subnet_useast1a_id

  # Uses your existing Bastion Security Group ID local
  vpc_security_group_ids = [local.mysql_sg_id]

  tags = merge(local.mysql_final_tags,
    {
      Name = "${var.project}-${var.environment}-mysql"
    }
  )
}
# step:2. Trigger file copy and execution when Instance ID changes
resource "terraform_data" "bootstrap_mysql" {
  triggers_replace = [
    aws_instance.mysql.id
  ]

  # Connection details for both provisioners
  connection {
    type     = "ssh"
    user     = "ec2-user" # Change to "ubuntu" if using Ubuntu AMI
    password = "DevOps321"
    host     = aws_instance.mysql.private_ip # Use .private_ip if inside a private VPC
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
      "sudo sh /tmp/bootstrap.sh mysql ${var.environment}"
    ]
  }
}

# 4) Rabbitmq: step:1 Create the redis EC2 Instance in database subnet
resource "aws_instance" "rabbitmq" {
  ami           = local.ami_id
  instance_type = var.inst_type

  # Uses the Subnet ID fetched from your SSM Parameter Store
  subnet_id = local.subnet_useast1a_id

  # Uses your existing Bastion Security Group ID local
  vpc_security_group_ids = [local.rabbitmq_sg_id]

  tags = merge(local.rabbitmq_final_tags,
    {
      Name = "${var.project}-${var.environment}-rabbitmq"
    }
  )
}
# step:2. Trigger file copy and execution when Instance ID changes
resource "terraform_data" "bootstrap_rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]

  # Connection details for both provisioners
  connection {
    type     = "ssh"
    user     = "ec2-user" # Change to "ubuntu" if using Ubuntu AMI
    password = "DevOps321"
    host     = aws_instance.rabbitmq.private_ip # Use .private_ip if inside a private VPC
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
      "sudo sh /tmp/bootstrap.sh rabbitmq ${var.environment}"
    ]
  }
}







