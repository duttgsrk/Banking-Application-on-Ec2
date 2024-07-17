provider "aws" {
  region = "ap-south-1"

}


resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Allow inbound traffic"
  vpc_id      = "vpc-0d17ff101a1d73170"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg"
  }
}



resource "aws_instance" "ec" {
  ami                         = "ami-0c2af51e265bd5e0e"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = "subnet-07289ec292e705287"
  vpc_security_group_ids      = [aws_security_group.sg.id]
  key_name                    = "KP1805"

  user_data = <<-EOF
 #!/bin/bash
     sudo apt-get update -y
 EOF

  tags = {
    Name = "Prod Server"
  }
}
