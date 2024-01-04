#creating a vpc resource
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.1.0.0/16"
    tags ={
        "Name" = "Testing env"
    }
  
}
 #create a subnet to the vpc for step 1
 resource "aws_subnet" "tf_public_subnet1" {
 cidr_block = "10.1.1.0/24"
 vpc_id = aws_vpc.my-vpc.id   
 availability_zone = "eu-west-2b"
 map_public_ip_on_launch = true
 tags = {
    "Name" = "testing-env-public-subnet"
 }
   
 }

 #create internet gateway
 resource "aws_internet_gateway" "tf-vpc-igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name ="tf-vpc-igw"
    }
   
 }

 #create a public route table
 resource "aws_route_table" "tf-vpc-public-rt" {
    vpc_id = aws_vpc.my-vpc.id
   
 }

 #we need to attach rt to igw and subnet
 resource "aws_route" "rt-association" {
    route_table_id = aws_route_table.tf-vpc-public-rt.id
    gateway_id = aws_internet_gateway.tf-vpc-igw.id
    destination_cidr_block = "0.0.0.0/0"
   
 }
 #map /associate the subnet created in rt
 resource "aws_route_table_association" "tf-public-rt-association" {
    route_table_id = aws_route_table.tf-vpc-public-rt.id
    subnet_id = aws_subnet.tf_public_subnet1.id
   
 }
 #creating a security group to loing to linux instance
 resource "aws_security_group" "my-sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "my-sg"
  }
}
##all good