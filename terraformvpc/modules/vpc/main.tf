#vpc
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    "Name" = "my_vpc"
  }
}
#subnet
resource "aws_subnet" "sub1" {
  count = length(var.subnet_cidr)
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index] #Dynamically selects an availability zone from the available zones in the region for each subnet being created, ensuring subnets are distributed across different availability zones
  map_public_ip_on_launch = true                    #This setting ensures that any EC2 instances launched in this subnet will be assigned a public IP address automatically
  tags = {
    Name = var.subnet_name[count.index]
  }
}
#INTERNET GATEWAY :
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "internet_gateway_vpc1"
  }
}

#Route table
resource "aws_route_table" "rtable" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id #the route table will correctly route any internet-bound traffic (destination 0.0.0.0/0) through the Internet Gateway.
  }
}

#route table association
resource "aws_route_table_association" "rtassociation" {
  count = length(var.subnet_cidr)
  subnet_id      = aws_subnet.sub1[count.index].id
  route_table_id = aws_route_table.rtable.id
}