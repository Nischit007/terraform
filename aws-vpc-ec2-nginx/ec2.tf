
resource "aws_instance" "ec2_server" {
  ami           = "ami-0d97d7f07b25dd693"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [ aws_security_group.public_sg.id ]
  associate_public_ip_address = true
  
  user_data = <<-EOF
    #!/bin/bash

    apt update -y
    apt install nginx -y

    systemctl start nginx
    systemctl enable nginx

    echo "Hello from Terraform EC2" > /var/www/html/index.html
  EOF

 
  tags = {
    email = "nischitpantha@gmail.com"
  }
}
