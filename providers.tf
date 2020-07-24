provider "aws" {
  region = "eu-west-2"

}

data "aws_region" "current" {
}

data "aws_availability_zones" "available" {
}

provider "http" {
}

terraform {
  backend "s3" {
    bucket = "s3-backend2020"
    key    = "terraform/eks-aws/terraform.tfstate"
    region = "eu-west-2"
  }
}