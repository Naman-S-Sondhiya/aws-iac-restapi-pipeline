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

resource "aws_subnet" "my_pub_subnets" {
    count = length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = element(var.public_subnet_cidrs, count.index)
    availability_zone = element(var.availability_zones, count.index)

    tags = {
        Name = "my-public-subnet-${count.index + 1}"    
    }
}

resource "aws_subnet" "my_priv_subnets" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = element(var.private_subnet_cidrs, count.index)
    availability_zone = element(var.availability_zones, count.index)

    tags = {
        Name = "my-private-subnet-${count.index + 1}"    
    }
}

resource "aws_route_table" "my_pub_rt" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
    }
    tags = {
        Name = "my-public-rt"
    }  
}

resource "aws_route_table_association" "my_pub_rt_assoc" {
    count = length(aws_subnet.my_pub_subnets)
    subnet_id = aws_subnet.my_pub_subnets[count.index].id
    route_table_id = aws_route_table.my_pub_rt.id
}