resource "aws_iam_user" "developer" {
  name = "Developer"
}

resource "aws_iam_user" "developer_lead" {
  name = "DeveloperLead"
}

resource "aws_iam_user_policy" "developer" {
  name = "DeveloperLeastPrivilege"
  user = aws_iam_user.developer.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:GetObject",
        "s3:PutObject"
      ]
      Resource = "arn:aws:s3:::secure-files-bucket/*"
    }]
  })
}

resource "aws_iam_user_policy" "developer_lead" {
  name = "DeveloperLeadLeastPrivilege"
  user = aws_iam_user.developer_lead.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ]
      Resource = "arn:aws:s3:::secure-files-bucket/*"
    }]
  })
}
