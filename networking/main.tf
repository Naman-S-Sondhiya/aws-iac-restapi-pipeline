resource "aws_vpc" "my_dev_vpc" {
    cidr_block = var.vpc_cidr
    tags = [
        Name = "my_dev_vpc_ap_south"
    ]
}

resource "aws_subnet" "my_dev_subnet" {
    count          = length(var.subnet_count)
    vpc_id           = aws_vpc.my_dev_vpc.id
    cidr_block        = length(var.subnet_cidr)
    availability_zone = element(ap-south-1a"
    tags = {
        Name = "my_dev_subnet_ap_south_1a"
    }   
}

resource "aws_subnet" "m"
resource "internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_dev_vpc.id
    tags = {
        Name = "igw_ap_south"
    }

 
}