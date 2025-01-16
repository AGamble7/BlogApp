# Provider Configuration
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "web_assets" {
  bucket = "my-devops-project-assets"
}

resource "aws_s3_bucket_policy" "web_assets_policy" {
  bucket = aws_s3_bucket.web_assets.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.web_assets.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "web_assets_config" {
  bucket = aws_s3_bucket.web_assets.id

  index_document {
    suffix = "index.html"
  }
}

# EC2 Instance
resource "aws_instance" "web_server" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "Welcome to DevOps Project" > /var/www/html/index.html
              EOF

  tags = {
    Name = "DevOpsProjectServer"
  }
}

# Security Group
resource "aws_security_group" "allow_http" {
  name_prefix = "web-sg-"
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

# Attach Security Group to EC2
resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = aws_security_group.allow_http.id
  network_interface_id = aws_instance.web_server.primary_network_interface_id
}
