terraform {
 
  required_providers {
    aws = {
        version = "5.13.0"
        source = "hashicorp/aws"
    }
  }

  #backend state file
  backend "s3" {
    bucket="my-ec2-bucket-ravi"
    region= "eu-west-2"
    key="logfiles"
    
  }
}
