resource "aws_vpc" "P_vpc" {
  cidr_block                       = "10.0.0.0/16"
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false
  tags = {
    Name = "MYVPC"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id =  aws_vpc.P_vpc.id

  tags = {
    Name = "myigw"
  }
}

# variable "cidr_block"{

# }
resource "aws_subnet" "pub_subnet" {
  vpc_id     = aws_vpc.P_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch= true
  tags = {
    Name = "pub_subnet"
  } 
}

resource "aws_subnet" "prv_subnet" {
  vpc_id     = aws_vpc.P_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch= false
  tags = {
    Name = "prv_subnet"
  } 
}

resource "aws_route_table" "pubroute" {
  vpc_id =  aws_vpc.P_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "pubroute"
  }
}

resource "aws_route_table" "prvroute" {
  vpc_id =  aws_vpc.P_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }
  tags = {
    Name = "prvroute"
  }
}

resource "aws_route_table_association" "pub" {
  subnet_id      = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.pubroute.id
}   

resource "aws_route_table_association" "prv" {
  subnet_id      = aws_subnet.prv_subnet.id
  route_table_id = aws_route_table.prvroute.id
} 


resource "aws_redshift_subnet_group" "redshift_subnet_group" {
  name       = "redshift-subnet-group"
  subnet_ids = [aws_subnet.prv_subnet.id]

  tags = {
    environment = "dev"
    Name = "redshift-subnet-group"
  }
}