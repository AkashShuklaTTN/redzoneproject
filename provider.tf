terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"

      # version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  shared_credentials_files = [ "/home/akash/.aws/credentials" ]
}
##terraform {
#3backend "s3" {
  ##  bucket         = "ter-backend-bucket"
   ## key            = "ter-backend-bucket/terraform.tfstate"
   ## encrypt        = true
   ## region         = "us-east-1"
    ##dynamodb_table = "ter-dyanamo-locking"
 ## }
##}
