provider "aws" {
  access_key = "AKIAIP6WKV2ECB4TLKVA"
  secret_key = "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"
  region = "ap-south-1"
}

resource "aws_instance" "front-end" {
  ami = "ami-0912f71e06545ad88"
  instance_type = "t2.micro"
  lifecycle {
    create_before_destroy = true  
  }
}

resource "aws_instance" "backend" {
  count = 2
  ami = "ami-0912f71e06545ad88"
  instance_type = "t2.micro"
  timeouts {
    create = "60m"
    delete = "2h"
  }
}



