resource "aws_vpc" "darede_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "public_subnets" {
    count = length(var.public_subnets)
    vpc_id = aws_vpc.darede_vpc.id
    cidr_block = var.public_subnets[count.index]
    availability_zone = var.azs[count.index]
    map_public_ip_on_launch = true
    tags = {
        Name = "kubernetes.io/role/elb"
        value = 1
    }
}

resource "aws_subnet" "private_subnets" {
    count = length(var.private_subnets)
    vpc_id = aws_vpc.darede_vpc.id
    cidr_block = var.private_subnets[count.index]
    availability_zone = var.azs[count.index]
    tags = {
        Name = "kubernetes.io/role/internal-elb"
        value = 1
  }
}

resource "aws_internet_gateway" "darede_igw" {
    vpc_id = aws_vpc.darede_vpc.id
    tags = {
        Name = "darede-igw"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.darede_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.darede_igw.id
    }
    tags = {
        Name = "public-route-table"
    }
}

resource "aws_route_table_association" "public_route_table_association" {
    count = length(var.public_subnets)
    subnet_id = aws_subnet.public_subnets[count.index].id
    route_table_id = aws_route_table.public_route_table.id
  
}

