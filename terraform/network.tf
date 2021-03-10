# Create VPC
resource "aws_vpc" "main-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "scalac-vpc"
  }
}

# Create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = "igw-scalac"
  }
}

# Declare the data source for all available AZs in the project region
data "aws_availability_zones" "az-available" {
  state = "available"
}

# Create public subnet
resource "aws_subnet" "pub-subnet" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = element(data.aws_availability_zones.az-available.names, 0)

  tags = {
    Name = "public-subnet"
  }
}

# # Create private subnet
# resource "aws_subnet" "priv-subnet" {
#   vpc_id            = aws_vpc.main-vpc.id
#   cidr_block        = "10.0.2.0/24"
#   availability_zone = element(data.aws_availability_zones.az-available.names, 1)

#   tags = {
#     Name = "private-subnet"
#   }
# }

# Create public RT in VPC
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Updating the default RT 
# Overwrite default rt of VPC with recent rt entries
resource "aws_main_route_table_association" "main-rt" {
  vpc_id         = aws_vpc.main-vpc.id
  route_table_id = aws_route_table.pub-rt.id
}

