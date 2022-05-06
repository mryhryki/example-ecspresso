resource "aws_vpc" "example_ecspresso" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example_ecspresso_1" {
  vpc_id            = aws_vpc.example_ecspresso.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "example_ecspresso_2" {
  vpc_id            = aws_vpc.example_ecspresso.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}

resource "aws_internet_gateway" "example_ecspresso" {
  vpc_id = aws_vpc.example_ecspresso.id
}

resource "aws_security_group" "example_ecspresso" {
  name   = "allow_http"
  vpc_id = aws_vpc.example_ecspresso.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.example_ecspresso.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
