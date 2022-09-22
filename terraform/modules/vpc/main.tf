resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  tags = {
    Service  = var.app_name
    Environment = var.stage
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Service  = var.app_name
    Environment = var.stage
  }
}

resource "aws_subnet" "main_a" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.main.id
  availability_zone = var.availability_zone_a
  tags = {
    Service  = var.app_name
    Environment = var.stage
  }
}

resource "aws_security_group" "tls_ssh" {
  name = "${var.app_name}-${var.stage}-allow_tls_ssh"
  description = "Allow TLS and SSH inbound trafic to the machine"
  vpc_id = aws_vpc.main.id
  ingress {
    description = "Allow TLS Connections"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTP Connections" # Certbot needs http to verify the certificate
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow SSH Connections"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Service  = var.app_name
    Environment = var.stage
  }
}

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Service  = var.app_name
    Environment = var.stage
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main_a.id
  route_table_id = aws_route_table.r.id
}

