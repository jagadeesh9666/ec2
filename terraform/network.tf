resource "aws_vpc" "ntier_vpc" {
  cidr_block = var.vpc_network_cidr
  tags = {
    Name = "tire"
  }
}
resource "aws_subnet" "app" {
  vpc_id     = aws_vpc.ntier_vpc.id
  cidr_block = "10.10.0.0/24"

  tags = {
    Name = "tire"
  }
}
resource "aws_security_group" "app" {
  name        = "app"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.ntier_vpc.id

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.ntier_vpc.cidr_block]
  }
  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.ntier_vpc.cidr_block]
  }
  ingress {
    description = "jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.ntier_vpc.cidr_block]
  }
  ingress {
    description = "https access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.ntier_vpc.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "app"
  }
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.ntier_vpc.id
  tags = {
    Name = "tire"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.ntier_vpc.id

  tags = {
    Name = "tire"
  }
}
resource "aws_route" "terra" {
  route_table_id         = aws_route_table.example.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}
