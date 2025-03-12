terraform {
  required_version = ">= 1.11.0"   

  backend "s3" {
    bucket         = "bucketname"  # Replace the bucket name with your actual S3 bucket name
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    use_lockfile   = true
    encrypt        = true
  }
}

module "ecr" {
  source    = "../../modules/ECR"
  repo_name = "nodejs-repo"
}

module "iam" {
  source          = "../../modules/IAM"
  iam_role_name   = "lambda_execution_role"
  iam_policy_name = "lambda_execution_policy"
}

module "lambda" {
  source             = "../../modules/LAMDA"
  lambda_name        = "nodejs-function"
  ecr_repository_url = "${module.ecr.ecr_repository_url}:default"
  iam_role_arn       = module.iam.iam_role_arn

  depends_on = [ module.ecr, module.iam ] 
}

 
