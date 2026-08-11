# 1. Create the IAM Role and define its Trust Policy (Allows EC2 to assume it)
resource "aws_iam_role" "mysql_role" {
  # FIXED: Matches exactly "RoboshopDevMySQL" without trailing hyphens or strings
  name = "${title(var.project)}${title(var.environment)}MySQL"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "://amazonaws.com"
        }
      }
    ]
  })
}

# 2. Read and populate the external JSON policy file dynamically
resource "aws_iam_policy" "mysql_ssm_policy" {
  name        = "${var.project}-${var.environment}-mysql-ssm-policy"
  description = "Allows read access strictly to the MySQL root password parameter"

  policy = templatefile("${path.module}/iam_role_policy.json", {
    project     = var.project
    environment = var.environment
  })
}

# 3. Attach the custom SSM policy to your MySQL role
resource "aws_iam_role_policy_attachment" "mysql_ssm_attach" {
  role       = aws_iam_role.mysql_role.name
  policy_arn = aws_iam_policy.mysql_ssm_policy.arn
}

# 4. Create the IAM Instance Profile (This is what the EC2 resource block calls)
resource "aws_iam_instance_profile" "mysql_profile" {
  name = "${var.project}-${var.environment}-mysql-profile"
  role = aws_iam_role.mysql_role.name
}
