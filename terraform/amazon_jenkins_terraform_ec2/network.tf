resource "aws_vpc" "jenkins_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-VPC"
  }
}
resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.jenkins_vpc.id}"
  tags = {
    Name = "${var.project_name}-Public-RouteTable"
  }
}
resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.jenkins_vpc.id}"
  tags = {
    Name = "${var.project_name}-Private-RouteTable"
  }
}
resource "aws_eip" "eip_nat_gw" {
  vpc                       = true
  associate_with_private_ip = "${var.eip_private_ip}"
  tags = {
    Name = "${var.project_name}-EIP"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.jenkins_vpc.id}"
  tags = {
    Name = "${var.project_name}-IGW"
  }
}
resource "aws_route" "public_internet_igw_route" {
  route_table_id         = "${aws_route_table.public_route_table.id}"
  gateway_id             = "${aws_internet_gateway.igw.id}"
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${aws_eip.eip_nat_gw.id}"
  subnet_id     = "${aws_subnet.public_subnet1.id}"
  tags = {
    Name = "${var.project_name}-NATGW"
  }
  depends_on = ["aws_internet_gateway.igw"]
}
resource "aws_route" "nat_gw_route" {
  route_table_id         = "${aws_route_table.private_route_table.id}"
  nat_gateway_id         = "${aws_nat_gateway.nat_gw.id}"
  destination_cidr_block = "0.0.0.0/0"
}