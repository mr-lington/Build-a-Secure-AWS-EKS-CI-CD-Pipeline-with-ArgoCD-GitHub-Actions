terraform {
  backend "s3" {
    region       = "eu-west-3"
    bucket       = "lington-terraform-state"
    key          = "foundation/s3/terraform.tfstate"
    use_lockfile = true
    encrypt      = true
  }
}