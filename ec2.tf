resource "aws_instance" "ec2-demo" {
    ami =var.ami
    instance_type = var.instance_type
    key_name = var.key_name
  
}