resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags                 = merge(var.tags, { Name = "${var.project}-${var.env}-vpc" })
}

resource "aws_subnet" "net" {
  for_each                = var.subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, each.value.cidr_index)
  availability_zone       = "${var.region}${each.value.az}"
  map_public_ip_on_launch = each.key == "public-a" ? true : false
  tags                    = merge(var.tags, { Name = "${var.project}-${var.env}-${each.key}" })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.tags, { Name = "${var.project}-${var.env}-igw" })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(var.tags, { Name = "${var.project}-${var.env}-rt" })
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.net["public-a"].id
  route_table_id = aws_route_table.public.id
}