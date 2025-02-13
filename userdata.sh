#!/bin/bash
#!/bin/bash
# Install Docker
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -aG docker ec2-user

# Pull Docker image (if hosted on ECR)
# aws ecr get-login-password | docker login --username AWS 
--password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com
# docker pull 
<AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/rails-app:latest

# Build and run the Rails app
docker run -d -p 3000:3000 rails-app

