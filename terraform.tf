provider "aws" {
  access_key = "AKIAIP6WKV2ECB4TLKVA"
  secret_key = "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"
  region = "ap-south-1"
}

resource "aws_instance" "test-ec2" {
  ami = "ami-0912f71e06545ad88"
  instance_type = "t2.micro"
}
