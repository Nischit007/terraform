output "aws_instance_public_ip" {
  value = "http://${aws_instance.ec2_server.public_ip}"
}