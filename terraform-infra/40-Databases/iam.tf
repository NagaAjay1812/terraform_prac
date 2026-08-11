resource "aws_iam_role" "mysql" {
  name = "${title(var.project)}${title(var.environment)}MySQL"

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

resource "aws_iam_policy" "mysql" {
  name        = "${var.project}-${var.environment}-mysql-ssm-policy"
  description = "Policy for MySQL EC2 instance"

  policy = templatefile("${path.module}/iam_role_policy.json", {
    project     = var.project
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
