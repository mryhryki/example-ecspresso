resource "aws_vpc" "example_ecspresso" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_route_table" "example_ecspresso" {
  vpc_id = aws_vpc.example_ecspresso.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_ecspresso.id
  }
}

resource "aws_subnet" "example_ecspresso_1" {
  vpc_id                  = aws_vpc.example_ecspresso.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "example_ecspresso_1" {
  subnet_id      = aws_subnet.example_ecspresso_1.id
  route_table_id = aws_route_table.example_ecspresso.id
}

resource "aws_subnet" "example_ecspresso_2" {
  vpc_id                  = aws_vpc.example_ecspresso.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "example_ecspresso_2" {
  subnet_id      = aws_subnet.example_ecspresso_2.id
  route_table_id = aws_route_table.example_ecspresso.id
}

resource "aws_internet_gateway" "example_ecspresso" {
  vpc_id = aws_vpc.example_ecspresso.id
}

resource "aws_security_group" "example_ecspresso" {
  name   = "example_ecspresso"
  vpc_id = aws_vpc.example_ecspresso.id

  ingress {
    description = "HTTP to VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TCP traffic to VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All traffic from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
