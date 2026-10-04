provider "aws" {
    region = "us-east-1"
}

#------------
#variables.tf
variable "my_custom_bucket" {
    type = string
    default = ""
}

#terraform.tfvars
my_custom_bucket = "kastro-bucket-virginia-13102025"

#main.tf
resource "aws_s3_bucket" "kastro-bucket" {
    bucket = var.my_custom_bucket
}
