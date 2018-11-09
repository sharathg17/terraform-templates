provider "aws" {
  access_key = "AKIAI5KTAM7RKFNPTAJA"
  secret_key = "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"
  region = "us-east-1"
}

provider "aws" {
  access_key = "AKIAI5KTAM7RKFNPTAJA"
  secret_key = "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"
  region = "us-west-1"
  alias = "west"
}

variable "us-east-zones" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "us-west-zones" {
  default = ["us-west-1a", "us-west-1b"]
}

variable "multi-region-deployment" {
  default = true
}

variable "environment-name" {
  default = "Terraform-demo"
}

resource "aws_instance" "east-frontend" {
  tags = {
   Name = "${join("-",list(var.environment-name, "frontend"))}"  
}
  count = "${var.multi-region-deployment ? 1 : 0}"
  depends_on = ["aws_instance.east-backend"]
  availability_zone = "${var.us-east-zones[count.index]}"
  ami = "ami-013be31976ca2c322"
  instance_type = "t2.micro"
}

resource "aws_instance" "east-backend" { 
  tags = {
   Name = "${join("-",list(var.environment-name, "backend"))}"  
}
  count = 2
  availability_zone = "${var.us-east-zones[count.index]}"
  ami = "ami-013be31976ca2c322"
  instance_type = "t2.micro"
}

resource "aws_instance" "west-frontend" {
  tags = {
   Name = "${join("-",list(var.environment-name, "frontend"))}"  
}
  provider = "aws.west"
  depends_on = ["aws_instance.west-backend"]
  availability_zone = "${var.us-west-zones[count.index]}"
  ami = "ami-01beb64058d271bc4"
  instance_type = "t2.micro"
}

resource "aws_instance" "west-backend" { 
  tags = {
   Name = "${join("-",list(var.environment-name, "backend"))}"  
}
  count = "${var.multi-region-deployment ? 2 : 0}"
  provider = "aws.west"
  availability_zone = "${var.us-west-zones[count.index]}"
  ami = "ami-01beb64058d271bc4"
  instance_type = "t2.micro"
}

output "east-frontend-ip" {
  value = "${aws_instance.east-frontend.*.public_ip}"
}

output "east-backend-ip" {
  value = "${aws_instance.east-backend.*.public_ip}"
}

output "west-frontend-ip" {
  value = "${aws_instance.west-frontend.*.public_ip}"
}

output "west-backend-ip" {
  value = "${aws_instance.west-backend.*.public_ip}"
}
