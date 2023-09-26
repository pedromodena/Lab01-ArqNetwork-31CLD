# Config
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 5.17"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

# VPC
resource "aws_vpc" "vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name    = var.vpc_name,
    Materia = var.resource_tags["Materia"],
    Projeto = var.resource_tags["Projeto"]
  }
}

# Sub-Net Publica
resource "aws_subnet" "subnet_public1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name    = "Public1",
    Materia = var.resource_tags["Materia"],
    Projeto = var.resource_tags["Projeto"]
  }
}

# Sub-Net Privada
resource "aws_subnet" "subnet_private1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name    = "Private1",
    Materia = var.resource_tags["Materia"],
    Projeto = var.resource_tags["Projeto"]
  }
}

# Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name    = "${var.vpc_name}-igw",
    Materia = var.resource_tags["Materia"],
    Projeto = var.resource_tags["Projeto"]
  }
}

# Route Table
resource "aws_route_table" "vpc_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name    = "rtb-${var.vpc_name}",
    Materia = var.resource_tags["Materia"],
    Projeto = var.resource_tags["Projeto"]
  }
}

resource "aws_main_route_table_association" "main_route_table" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.vpc_route_table.id
}

# Criação da VM
resource "aws_instance" "app_server" {
  ami           = var.amazon_linux_2023_x64_ami
  instance_type = "t2.micro"

  tags = {
    Name    = var.ec2_name,
    Materia = var.resource_tags["Materia"],
    Projeto = var.resource_tags["Projeto"]
  }

  subnet_id                   = aws_subnet.subnet_public1.id
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  user_data                   = file("init.sh")
  user_data_replace_on_change = true
}

# Security Group da VM
resource "aws_security_group" "ec2_security_group" {
  vpc_id = aws_vpc.vpc.id

  # Ingress rule 1 (HTTP 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # All trafic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.ec2_name}-sg",
    Materia = var.resource_tags["Materia"],
    Projeto = var.resource_tags["Projeto"]
  }

  name = "${var.ec2_name}-sg"
}