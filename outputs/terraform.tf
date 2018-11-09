provider "aws" {
  access_key = "xx"
  secret_key = "xx"
  region = "ap-south-1"
}

resource "aws_instance" "frontend" {
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
}

output "frontend ip" {
  value = "${aws_instance.frontend.public_ip}"
}

output "backend ips" {
  value = "${aws_instance.backend.*.public_ip}"
}

