# Create an IAM role for Lambda
resource "aws_iam_role" "lambda_execution_role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Fetching the account ID
data "aws_caller_identity" "current" {}


resource "aws_iam_policy" "lambda_execution_policy" {
  name        = var.iam_policy_name
  description = "IAM policy to allow Lambda execution"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:ap-south-1:${data.aws_caller_identity.current.account_id}:*"
      },
      {
        Effect = "Allow"
        Action = [
          "lambda:InvokeFunction",
          "lambda:InvokeFunctionUrl"
        ]
        Resource = "arn:aws:lambda:ap-south-1:${data.aws_caller_identity.current.account_id}:*"
      }
    ]
  })
}


resource "aws_iam_policy_attachment" "lambda_execution_attach" {
  name       = "LambdaExecutionAttachment"
  roles      = [ aws_iam_role.lambda_execution_role.name ]
  policy_arn = aws_iam_policy.lambda_execution_policy.arn
  depends_on = [ aws_iam_role.lambda_execution_role, aws_iam_policy.lambda_execution_policy ]
}
 



 
