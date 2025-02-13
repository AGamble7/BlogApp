terraform {
  #AWS region the resources are in
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

resource "aws_security_group" "rails_sg" {
  name        = "rails-security-group"
  description = "Allow SSH and HTTP"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH (change for security)
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow Rails App access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "RailsApp_Ec2" {
  ami                    = "ami-04b4f1a9cf54c11d0" # Amazon Linux 2 (Update as needed)
  instance_type          = "t2.micro"
  key_name               = "rails_app" # Replace with your key pair
  security_groups        = [aws_security_group.rails_sg.name]
  user_data              = file("userdata.sh")

  tags = {
    Name = "RailsAppEC2"
  }
}
