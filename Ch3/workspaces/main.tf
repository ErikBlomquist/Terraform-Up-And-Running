# Workspaces
# 1. terraform workspace new example1
# 2. terraform workspace list
# 3. terraform workspace select example1

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
        bucket          = "kork-test"
        key             = "workspaces/terraformtfstate"
        region          = "us-east-2"

        dynamodb_table  = "kork-test-locks"
        encrypt         = true
    }
}

resource "aws_instance" "example" {
    ami = "ami-0c55b159cbfafe1f0"
    # Set instance type to t2.medium in default workspace and t2.micro in all other.
    # instance_type = terraform.workspace == "default" ? "t2.medium" : "t2.micro"
    instance_type = "t2.micro"
}