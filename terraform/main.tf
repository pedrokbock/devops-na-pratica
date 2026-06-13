terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# --- VARIÁVEIS ---
variable "aws_region" {
  description = "Regiao da AWS para provisionamento"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Tipo da instancia EC2"
  type        = string
  default     = "t2.micro"
}

# --- RECURSOS ---

resource "aws_s3_bucket" "app_storage" {
  bucket        = "projeto-devops-storage-pedrokbock"
  force_destroy = true

  tags = {
    Name        = "Bucket-Projeto-DevOps"
    Environment = "Dev"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "devops-projeto-sg"
  description = "Permitir trafego HTTP e SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "Servidor-Projeto-DevOps"
  }
}

# --- OUTPUTS ---
output "instance_public_ip" {
  description = "IP Publico gerado para o servidor EC2"
  value       = aws_instance.web_server.public_ip
}

output "s3_bucket_name" {
  description = "Nome do bucket S3 criado"
  value       = aws_s3_bucket.app_storage.id
}
