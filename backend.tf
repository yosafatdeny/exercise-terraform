terraform {
  backend "s3" {
      bucket = "jcde-terraform-state" #NAMA BUCKET DI S3 AWS
      key = "exercise2-terraform/demo1/tfstate"
      region = "ap-southeast-1"
  }
}