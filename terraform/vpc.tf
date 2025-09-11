resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = { Name = "${var.project}-vpc" }
}

resource "aws_subnet" "public" {
  for_each = toset(var.public_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = each.value
  map_public_ip_on_launch = true
  tags = { Name = "${var.project}-public-${each.key}" }
}

resource "aws_subnet" "private" {
  for_each = toset(var.private_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = each.value
  tags = { Name = "${var.project}-private-${each.key}" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route { cidr_block = "0.0.0.0/0"; gateway_id = aws_internet_gateway.igw.id }
}

resource "aws_route_table_association" "pub_assoc" {
  for_each = aws_subnet.public
  subnet_id = each.value.id
  route_table_id = aws_route_table.public.id
}
