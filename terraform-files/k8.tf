provider "aws" {
  profile = "deafult"
  region  = "ap-northeast-1"
}
resource "aws_instance" "k8" {
  ami                    = "ami-06631ebafb3ae5d34"
  instance_type          = "t2.micro"
  key_name               = "tokyo1"
  vpc_security_group_ids = ["sg-0068d68db6ff4b5a6"]
  tags = {
    Name = "k8"
  }
  user_data = <<-EOF
  #!/bin/bash
  hostnamectl set-hostname k8_minikube
  yum install -y docker conntrack
  service docker start
  curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x ./kubectl
  mv ./kubectl /usr/sbin/
  curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64   && chmod +x minikube
  install minikube /usr/sbin/
  minikube start --driver=none
  useradd ansible
  echo "ansible  ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
  su - ansible ; mkdir from-master
  EOF
}
output "public_ip_jenkins" {
  value       = aws_instance.t-j.public_ip
  description = "this is jenkins server public ip"
}

