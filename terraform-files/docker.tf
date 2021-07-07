provider "aws" {
  profile = "deafult"
  region  = "ap-northeast-1"
}
resource "aws_instance" "docker_server" {
  ami                    = "ami-06631ebafb3ae5d34"
  instance_type          = "t2.micro"
  key_name               = "tokyo1"
  vpc_security_group_ids = ["sg-0068d68db6ff4b5a6"]
  tags = {
    Name = "docker_server"
  }
  user_data = <<-EOF
  #!/bin/bash
  hostnamectl set-hostname docker_server
  yum install -y docker
  service docker start
  useradd ansible
  mkdir /home/ansible/from-master
  EOF
}
output "public_ip_docker" {
  value       = aws_instance.docker_server.public_ip
  description = "this is docker server public ip"
}
