project_name  = "Jenkins-Terraform"
region = "us-east-1"
instance_type = "t2.medium"

eip_private_ip = "10.0.0.5"

vpc_cidr = "10.0.0.0/16"

public_subnet_1_cidr  = "10.0.1.0/24"
public_subnet_2_cidr  = "10.0.2.0/24"
public_subnet_3_cidr  = "10.0.3.0/24"

private_subnet_1_cidr = "10.0.10.0/24"
private_subnet_2_cidr = "10.0.11.0/24"
private_subnet_3_cidr = "10.0.12.0/24"
