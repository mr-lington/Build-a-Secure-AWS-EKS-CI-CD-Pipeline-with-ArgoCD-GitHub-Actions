module "iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "6.2.1"

  name = "github-actions"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ecr:GetAuthorizationToken"]
        Resource = ["*"]
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
        Resource = [
          for repo in module.ecr :
          repo.repository_arn
        ]
      },
    ]
  })
}


module "github_actions_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role"

  name               = "github-actions"
  enable_github_oidc = true
  use_name_prefix    = false

  oidc_wildcard_subjects = [
    "repo:${var.github_repo}:ref:refs/tags/v*",
    "repo:${var.github_repo}:ref:refs/heads/main"
  ]

  policies = {
    ECRPush = module.iam_policy.arn
  }
}
