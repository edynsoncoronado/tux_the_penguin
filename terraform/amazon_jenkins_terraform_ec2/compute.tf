resource "aws_instance" "jenkins_instance" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.keypair.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.sg_allow_ssh_jenkins.id}" ]
  subnet_id          = "${aws_subnet.public_subnet1.id}"
  associate_public_ip_address = true
  user_data = "${file("install_jenkins.sh")}"
  tags = {
    Name = "${var.project_name}-instance"
  }
}

resource "aws_key_pair" "keypair" {
  key_name   = "${var.project_name}-Keypair"
	public_key = "***"
}

resource "aws_security_group" "sg_allow_ssh_jenkins" {
  name        = "allow_ssh_jenkins"
  description = "Allow SSH and Jenkins inbound traffic"
  vpc_id      = "${aws_vpc.jenkins_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
