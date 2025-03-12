# Create an AWS ECR 
resource "aws_ecr_repository" "ecr_repo" {
  name                 = var.repo_name
  image_tag_mutability = "MUTABLE"
  force_delete = true
  
  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }
}
  
