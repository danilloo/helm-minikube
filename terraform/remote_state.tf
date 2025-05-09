terraform {
  backend "s3" {
    bucket = "bucket-tfstate-terraform-teste-q1w2e3"
    encrypt = "true"
    key    = "app/terraform.tfstate"
    region = "us-east-1"
  }
}