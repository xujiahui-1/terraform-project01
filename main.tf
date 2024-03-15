provider "aws" {
    # 如果你用export设置了环境变量，这里可以为空
    region = "us-east-1"
    access_key = "XXXX"
    secret_key = "XXXX"
}

//定义变量
variable "subnet_cidr_block" {
    description = "subnet cidr block "
    
    default = "172.31.80.0/20"

    type = string
  
}

resource "aws_vpc" "development-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name: "development"
    vpc_env: "dev"
  }

}

resource "aws_subnet" "development-subnet-1" {
  vpc_id     = aws_vpc.development-vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "us-east-1a"

    tags = {
        Name: "development-subnet1"
    }
}

data "aws_vpc" "existing_vpc" {
  default = true
}
resource "aws_subnet" "development-subnet-2" {
  vpc_id     = data.aws_vpc.existing_vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = "us-east-1a"

    tags = {
        Name: "default-subnet1"
    }
}

output "exsepol" {
  value = aws_subnet.development-subnet-1.id
}