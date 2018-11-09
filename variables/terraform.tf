provider "aws" {
  access_key = "AKIAI5KTAM7RKFNPTAJA"
  secret_key = "KI/IjiLqiY8qmsfT8oUM0uUC4tVJIqGIAHVveoJB"
  region     = "us-east-1"
}

variable "zones" {
  default = ["us-east-1a", "us-east-1b"]
}

resource "aws_instance" "example" {
  count                 = 2
  availability_zone     = "${var.zones[count.index]}"
  ami                   = "ami-07585467"
  instance_type         = "t2.micro"
}


