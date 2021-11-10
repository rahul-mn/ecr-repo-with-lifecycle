resource "aws_ecr_repository" "Shared_ECR" {
  name                 = "shared-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "Shared_ECR_Policy" {
  repository = aws_ecr_repository.Shared_ECR.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Rule 1",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": ${var.countNumber}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
