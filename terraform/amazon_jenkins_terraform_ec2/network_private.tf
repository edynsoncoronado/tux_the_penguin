resource "aws_subnet" "private_subnet1" {
  cidr_block        = "${var.private_subnet_1_cidr}"
  vpc_id            = "${aws_vpc.jenkins_vpc.id}"
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.project_name}-Private-Subnet-1"
  }
}
resource "aws_subnet" "private_subnet2" {
  cidr_block        = "${var.private_subnet_2_cidr}"
  vpc_id            = "${aws_vpc.jenkins_vpc.id}"
  availability_zone = "${var.region}b"
  tags = {
    Name = "${var.project_name}-Private-Subnet-2"
  }
}
resource "aws_subnet" "private_subnet3" {
  cidr_block        = "${var.private_subnet_3_cidr}"
  vpc_id            = "${aws_vpc.jenkins_vpc.id}"
  availability_zone = "${var.region}c"
  tags = {
    Name = "${var.project_name}-Private-Subnet-3"
  }
}
resource "aws_route_table_association" "private_route1_association" {
  route_table_id = "${aws_route_table.private_route_table.id}"
  subnet_id      = "${aws_subnet.private_subnet1.id}"
}
resource "aws_route_table_association" "private_route2_association" {
  route_table_id = "${aws_route_table.private_route_table.id}"
  subnet_id      = "${aws_subnet.private_subnet2.id}"
}
resource "aws_route_table_association" "private_route3_association" {
  route_table_id = "${aws_route_table.private_route_table.id}"
  subnet_id      = "${aws_subnet.private_subnet3.id}"
}
