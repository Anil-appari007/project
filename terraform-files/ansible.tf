provider "aws" {
  profile = "deafult"
  region  = "ap-northeast-1"
}
resource "aws_instance" "t-ansible" {
  ami                    = "ami-06631ebafb3ae5d34"
  instance_type          = "t2.micro"
  key_name               = "tokyo1"
  vpc_security_group_ids = ["sg-0068d68db6ff4b5a6"]
  tags = {
    Name = "ansible_server"
  }
  user_data = <<-EOF
  #!/bin/bash
  hostnamectl set-hostname ansible_server
  amazon-linux-extras install -y epel
  yum install -y ansible
  useradd ansible
  su - ansible ; mkdir /home/ansible/from-jenkins
  EOF
}
output "public_ip_ansible" {
  value       = aws_instance.t-ansible.public_ip
  description = "this is ansible server public ip"
}
