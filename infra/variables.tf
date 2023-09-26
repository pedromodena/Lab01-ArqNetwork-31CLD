variable "resource_tags" {
  description = "Tags"
  type        = map(string)
  default = {
    "Materia" = "Arquitetura Network",
    "Projeto" = "LAB01-VPC"
  }
}

variable "vpc_name" {
  type    = string
  default = "vpc-arqnet-lab01"
}

variable "amazon_linux_2023_x64_ami" {
  description = "Amazon Linux 2023 AMI 2023.2.20230920.1 x86_64 HVM kernel-6.1"
  type        = string
  default     = "ami-03a6eaae9938c858c"
}

variable "ec2_name" {
  type    = string
  default = "srv-arqnet-lab01"
}