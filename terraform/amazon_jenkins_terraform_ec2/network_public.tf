resource "aws_subnet" "public_subnet1" {
  cidr_block        = "${var.public_subnet_1_cidr}"
  vpc_id            = "${aws_vpc.jenkins_vpc.id}"
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.project_name}-Public-Subnet-1"
  }
}
resource "aws_subnet" "public_subnet2" {
  cidr_block        = "${var.public_subnet_2_cidr}"
  vpc_id            = "${aws_vpc.jenkins_vpc.id}"
  availability_zone = "${var.region}b"
  tags = {
    Name = "${var.project_name}-Public-Subnet-2"
  }
}
resource "aws_subnet" "public_subnet3" {
  cidr_block        = "${var.public_subnet_3_cidr}"
  vpc_id            = "${aws_vpc.jenkins_vpc.id}"
  availability_zone = "${var.region}c"
  tags = {
    Name = "${var.project_name}-Public-Subnet-3"
  }
}

resource "aws_route_table_association" "public_route1_association" {
  route_table_id = "${aws_route_table.public_route_table.id}"
  subnet_id      = "${aws_subnet.public_subnet1.id}"
}
resource "aws_route_table_association" "public_route2_association" {
  route_table_id = "${aws_route_table.public_route_table.id}"
  subnet_id      = "${aws_subnet.public_subnet2.id}"
}
resource "aws_route_table_association" "public_route3_association" {
  route_table_id = "${aws_route_table.public_route_table.id}"
  subnet_id      = "${aws_subnet.public_subnet3.id}"
}
