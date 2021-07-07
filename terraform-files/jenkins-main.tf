provider "aws" {
  profile = "deafult"
  region  = "ap-northeast-1"
}
resource "aws_instance" "t-j" {
  ami                    = "ami-06631ebafb3ae5d34"
  instance_type          = "t2.micro"
  key_name               = "tokyo1"
  vpc_security_group_ids = ["sg-0068d68db6ff4b5a6"]
  tags = {
    Name = "Jenkins_server"
  }
  user_data = <<-EOF
  #!/bin/bash
  hostnamectl set-hostname jenkins_server
  yum install -y java git
  sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
  rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
  yum upgrade -y
  yum install jenkins java-11-openjdk-devel -y
  systemctl daemon-reload
  service jenkins start
  EOF
}
output "public_ip_jenkins" {
  value       = aws_instance.t-j.public_ip
  description = "this is jenkins server public ip"
}

