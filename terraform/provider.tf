# Configure the AWS Provider
provider "aws" {
  profile = var.profile
  region  = var.region
}
