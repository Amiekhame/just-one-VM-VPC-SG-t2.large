resource "aws_vpc" "vpc" {
    cidr_block       = var.cidr_block
    instance_tenancy = "default"

    tags = {
        Name = "${var.project_name}-vpc"
    }
}

#######################################

data "aws_availability_zones" "available" {
    state = "available"
}

########################################

resource "aws_subnet" "subnet_a" {
    vpc_id     = aws_vpc.vpc.id
    cidr_block = var.subnet_a_cidr_block
    map_public_ip_on_launch = "true"
    availability_zone = data.aws_availability_zones.available.names[0]

    tags = {
        Name = "${var.project_name}-subnet_a"
    }
}

########################################

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.project_name}-igw"
    }
}

########################################

resource "aws_route_table" "rt_a" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "${var.project_name}-rt_a"
    }
}

resource "aws_route_table_association" "rta_a" {
    subnet_id      = aws_subnet.subnet_a.id
    route_table_id = aws_route_table.rt_a.id
}






