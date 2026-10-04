#variables.tf
provider "aws" {
    region = "us-east-1"
}

variable "instance_count" {
    type = number
}

variable "instance_ami" {
    type = string
}

variable "instance_type" {
    type = string
}

variable "instance_name" {
    type = string
}

#dev-team.tfvars
instance_count = 2
instance_ami = "ami-052064a798f08f0d3"
instance_type = "t2.micro"
instance_name = "dev-server"

#test-team.tfvars
instance_count = 2
instance_ami = "ami-052064a798f08f0d3"
instance_type = "t2.micro"
instance_name = "test-server"

#prod-team.tfvars
instance_count = 2
instance_ami = "ami-052064a798f08f0d3"
instance_type = "t2.micro"
instance_name = "prod-server"

#main.tf
resource "aws_instance" "my_vm" {
    count = var.instance_count
    ami = var.instance_ami
    instance_type = var.instance_type

    tags = {
        Name = "${var.instance_name}-${count.index + 1}"
    }
}

#main.tf with for_each block
resource "aws_instance" "my_vm" {
    for_each = {
        for i in range(var.instance_count):
        "${var.instance_name}-${i+1}" => var.instance_ami
    }

    ami = each.value
    instance_type = var.instance_type

    tags = {
        Name = each.key
    }
}
