provider "aws" {
  access_key = "xx"
  secret_key = "xx"
  region = "us-east-1"
}

provider "aws" {
  access_key = "xx"
  secret_key = "xx"
  region = "us-west-1"
  alias = "west"
}

variable "us-east-zones" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "us-west-zones" {
  default = ["us-west-1a", "us-west-1b"]
}

resource "aws_instance" "east-frontend" {
  count = 2 
  depends_on = ["aws_instance.east-backend"]
  availability_zone = "${var.us-east-zones[count.index]}"
  ami = "ami-013be31976ca2c322"
  instance_type = "t2.micro"
#  lifecycle {
#    prevent_destroy = true
#  }
}

resource "aws_instance" "east-backend" { 
  count = 2 
  availability_zone = "${var.us-east-zones[count.index]}"
  ami = "ami-013be31976ca2c322"
  instance_type = "t2.micro"
#  lifecycle {
#    prevent_destroy = true
#  }
}

resource "aws_instance" "west-frontend" {
  provider = "aws.west"
  count = 2 
  depends_on = ["aws_instance.west-backend"]
  availability_zone = "${var.us-west-zones[count.index]}"
  ami = "ami-01beb64058d271bc4"
  instance_type = "t2.micro"
#  lifecycle {
#    prevent_destroy = true
#  }
}

resource "aws_instance" "west-backend" { 
  provider = "aws.west"
  count = 2 
  availability_zone = "${var.us-west-zones[count.index]}"
  ami = "ami-01beb64058d271bc4"
  instance_type = "t2.micro"
#  lifecycle {
#    prevent_destroy = true
#  }
}

output "east-frontend-ips" {
  value = "${aws_instance.east-frontend.*.public_ip}"
}

output "east-backend-ips" {
  value = "${aws_instance.east-backend.*.public_ip}"
}

output "west-frontend-ips" {
  value = "${aws_instance.west-frontend.*.public_ip}"
}

output "west-backend-ips" {
  value = "${aws_instance.west-backend.*.public_ip}"
}
