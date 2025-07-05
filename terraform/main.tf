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

