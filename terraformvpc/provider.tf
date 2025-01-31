terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
terraform {
  backend "s3" {
    bucket = "terraform-remote-backend-s3"
    key    = "dev/terraform.tfstate"
    region = "global"
  }
}

# Configure the AWS Provider
provider "aws" {
  profile = "awsstudent"
  region = "global"
}