#vpc
resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    "name" = "vpc1"
  }
}


#subnet

resource "aws_subnet" "sub1" {
  count = length(var.subnet_cidr)
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet_name[count.index]
  }
}

#INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "internet_gateway_vpc1"
  }
}

#route table
resource "aws_route_table" "rtable" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/24"
    gateway_id = aws_internet_gateway.igw.id
  }
}

#route table association
resource "aws_route_table_association" "rta" {
  count = length(var.subnet_cidr)
  subnet_id      = aws_subnet.sub1[count.index].id
  route_table_id = aws_route_table.rtable.id
}