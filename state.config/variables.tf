variable "region" {
  type        = string
  description = "AWS region to provision infrastructure."
}

variable "bucket" {
  type        = string
  description = "S3 bucket for terraform state."
}

variable "github_repos" {
  type        = list(string)
  description = "GitHub repositories."
}




# terraform {
#   backend "s3" {
#     region       = "eu-west-3"
#     bucket       = "lington-terraform-state"
#     key          = "s3-ecr-iam/s3/terraform.tfstate"
#     use_lockfile = true
#     encrypt      = true
#   }
# }