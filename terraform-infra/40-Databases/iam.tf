# 1. Create the IAM Role and define its Trust Policy (Allows EC2 to assume it)
resource "aws_iam_role" "mysql" {
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
resource "aws_iam_policy" "mysql" {
  name        = "${var.project}-${var.environment}-mysql-ssm-policy"
  description = "policy for MySQL EC2 Instance"

  policy = templatefile("iam_role_policy.json", {
    environment = var.environment
  })
}

# 3. Attach the custom SSM policy to your MySQL role
resource "aws_iam_role_policy_attachment" "mysql" {
  role       = aws_iam_role.mysql.name
  policy_arn = aws_iam_policy.mysql.arn
}

# 4. Create the IAM Instance Profile (This is what the EC2 resource block calls)
resource "aws_iam_instance_profile" "mysql" {
  name = "${var.project}-${var.environment}-mysql-profile"
  role = aws_iam_role.mysql.name
}
