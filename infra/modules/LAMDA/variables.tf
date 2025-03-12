variable "lambda_name" {
  description = "Lambda function name"
  type        = string
}

variable "iam_role_arn" {
  description = "IAM role ARN for Lambda execution"
  type        = string
}

variable "ecr_repository_url" {
  description = "ECR repository URL for Lambda image"
  type        = string
}

