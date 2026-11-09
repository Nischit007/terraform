
# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    email = "nischitpantha@gmail.com"
  }
}

# Create Public Subnet
resource "aws_subnet" "public_subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.my_vpc.id
   availability_zone = "us-east-1c"

  depends_on = [
    aws_vpc.my_vpc
  ]

  tags = {
    email = "nischitpantha@gmail.com"
  }
}

# Create Private Subnet
resource "aws_subnet" "private_subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.my_vpc.id
   availability_zone = "us-east-1b"

  depends_on = [
    aws_vpc.my_vpc
  ]

  tags = {
    email = "nischitpantha@gmail.com"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  depends_on = [
    aws_vpc.my_vpc
  ]

  tags = {
    email = "nischitpantha@gmail.com"
  }
}

# Create Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  depends_on = [
    aws_internet_gateway.my_igw
  ]

  tags = {
    email = "nischitpantha@gmail.com"
  }
}

# Associate Public Route Table with Public Subnet
resource "aws_route_table_association" "public_rt_association" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet.id

  depends_on = [
    aws_route_table.public_rt,
    aws_subnet.public_subnet
  ]
}