resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "my-vpc-ap-south"
    }
}

resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        Name = "igw-ap-south"
    }
}

resource "aws_subnet" "my_pub_subnet" {
    count = length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = element(var.public_subnet_cidrs, count.index)
    availability_zone = element(var.availability_zones, count.index)

    tags = {
        Name = "my-public-subnet-${count.index + 1}"    
    }
}

resource "aws_subnet" "my_priv_subnet" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = element(var.private_subnet_cidrs, count.index)
    availability_zone = element(var.availability_zones, count.index)

    tags = {
        Name = "my-private-subnet-${count.index + 1}"    
    }
}