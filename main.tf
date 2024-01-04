resource "aws_instance" "ec2-demo" {
    ami ="ami-093cb9fb2d34920ad"
    instance_type = "t2.micro"
    key_name = "terraform"
  
}