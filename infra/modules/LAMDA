# Create the Lambda function using ECR image
resource "aws_lambda_function" "lambda_function" {
  function_name = var.lambda_name
  role          = var.iam_role_arn
  image_uri     = var.ecr_repository_url
  package_type  = "Image"

  environment {
    variables = {
      NODE_ENV = "dev"
    }
  }

}

 

