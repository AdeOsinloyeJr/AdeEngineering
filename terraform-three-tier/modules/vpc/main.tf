resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = { Name = "ThreeTier-VPC" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "ThreeTier-IGW" }
}

# Public Subnets
resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = { Name = count.index == 0 ? "Public-1a" : "Public-1b" }
}

# Private Subnets (App + DB)
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = count.index < 2 ? (count.index == 0 ? "App-1a" : "App-1b") : (count.index == 2 ? "DB-1a" : "DB-1b")
  }
}

# NAT Gateway
resource "aws_eip" "nat" {
  tags = { Name = "ThreeTier-NAT-EIP" }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
  tags = { Name = "ThreeTier-NATGW" }
}

# Route Tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "Public-RT" }
}

resource "aws_route_table_association" "public_assoc" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "app" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
  tags = { Name = "App-RT" }
}

resource "aws_route_table_association" "app_assoc" {
  count          = 2
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.app.id
}

resource "aws_route_table" "db" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "DB-RT" }
}

resource "aws_route_table_association" "db_assoc" {
  count          = 2
  subnet_id      = aws_subnet.private[count.index + 2].id
  route_table_id = aws_route_table.db.id
}

data "aws_availability_zones" "available" {}
