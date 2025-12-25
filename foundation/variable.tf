variable "region" {
  type        = string
  description = "AWS region to provision infrastructure."
}


variable "github_repo" {
  type        = string
  description = "GitHub repositories allowed to assume the role"
}

variable "ecr_repositories" {
  description = "List of ECR repositories to create"
  type        = list(string)
}
