resource "aws_iam_role" "lambda_iam_role" {
  name               = var.lambda_iam_role
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  }
  )

  inline_policy {
    name   = var.iam_policy_bedrock
    policy = jsonencode({
      Version   = "2012-10-17"
      Statement = [
        {
          Action = [
            "bedrock: InvokeModelWithResponseStream"
          ]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }

  inline_policy {
    name   = var.iam_policy_cw_log
    policy = jsonencode({
      Version   = "2012-10-17"
      Statement = [
        {
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
          ]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }
}



