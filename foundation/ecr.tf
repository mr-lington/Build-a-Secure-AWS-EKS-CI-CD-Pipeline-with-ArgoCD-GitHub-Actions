module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "3.1.0"

  for_each = toset(var.ecr_repositories)

  repository_name = each.key

  # Allow Terraform to delete repos even if images exist (CI/dev best practice) ## only do this in dev stage
  repository_force_delete = true

  # Enable vulnerability scanning on every push
  repository_image_scan_on_push = true

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 30 versioned images"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["v"]
          countType     = "imageCountMoreThan"
          countNumber   = 30
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
