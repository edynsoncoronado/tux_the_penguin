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
