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

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${aws_eip.eip_nat_gw.id}"
  subnet_id     = "${aws_subnet.public_subnet1.id}"
  tags = {
    Name = "${var.project_name}-NATGW"
  }
  depends_on = ["aws_eip.eip_nat_gw"]
}
