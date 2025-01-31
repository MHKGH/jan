
terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-6010"
    key    = "Terraform_State_file/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
  }
}


