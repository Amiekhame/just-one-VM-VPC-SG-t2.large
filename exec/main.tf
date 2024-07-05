provider "aws" {
    region   = var.region
    profile = "osho"
}

module "vpc_modules" {
    source = "../modules/vpc_modules"
    project_name = var.project_name
    cidr_block = var.cidr_block
    subnet_a_cidr_block = var.subnet_a_cidr
}

module "security_modules" {
    source = "../modules/security_modules"
    vpc_id = module.vpc_modules.vpc_id
    project_name = var.project_name
}

module "instance_modules" {
    source = "../modules/instance_modules"
    ami = var.ami
    project_name = var.project_name
    instance_type = var.instance_type
    sg_1_id = module.security_modules.sg_1_id
    subnet_a_id = module.vpc_modules.subnet_a_id
}


