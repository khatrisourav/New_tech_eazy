provider "aws" {
  region = var.region
}

resource "aws_security_group" "ec2_sg" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic and all outbound traffic"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_sg"
  }
}

resource "aws_instance" "EC2_deploy_on_aws" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]

 user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y curl unzip jq

              # Install AWS CLI v2
              curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
              unzip awscliv2.zip
              sudo ./aws/install

              # Download config
              curl -o /home/ubuntu/config.json "${var.config_file_url}"

              # ✅ Corrected setup.sh download
              curl -o /home/ubuntu/setup.sh "https://raw.githubusercontent.com/khatrisourav/New_tech_eazy/main/scripts/setup.sh"
              chmod +x /home/ubuntu/setup.sh

              # Execute setup.sh with stage param
              bash /home/ubuntu/setup.sh ${var.stage}
              EOF


  tags = {
    Name  = "EC2-${var.stage}"
    Stage = var.stage
  }
}

