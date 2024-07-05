output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "project_name" {
    value = var.project_name
}

output "subnet_a_id" {
    value = aws_subnet.subnet_a.id
}


output "igw_id" {
    value = aws_internet_gateway.igw.id
}