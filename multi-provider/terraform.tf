provider "aws" {
  access_key = "xx"
  secret_key = "xx"
  region = "ap-south-1"
}

provider "aws" {
  access_key = "xx"
  secret_key = "xx"
  alias = "ap-southeast-1"
  region = "ap-southeast-1"
}


resource "aws_instance" "ec2-a" {
  provider = "aws.ap-southeast-1"
  ami = "ami-085fd1bd447be68e8"
  instance_type = "t2.micro"
}

resource "aws_instance" "ec2-b" {
  ami = "ami-0912f71e06545ad88"
  instance_type = "t2.micro"
}



