# This creates the backend in S3 that will store the terraform statefile.
terraform {
  required_version = ">=0.14.3"
  backend "s3" {
    profile = "CodecommitUser"
    bucket  = "zubyranks-terraform"
    key     = "terraform_state_file"
    region  = "eu-central-1"
  }
}

