terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "aws" {
  region = "us-east-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

terraform {
    backend "s3" {
        bucket          = "korkbots-terraform-up-and-running-state"
        key             = "workspaces-example/terraform.tfstate"
        region          = "us-east-2"
        dynamodb_table  = "terraform-up-and-running-locks"
        encrypt         = true
    }
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = terraform.workspace == "default" ? "t2.medium" : "t2.micro"
}