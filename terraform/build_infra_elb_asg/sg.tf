resource "aws_security_group" "allow_ssh_http_anywhere" {
  name        = "${var.project_name}-allow_ssh_http_anywhere"
  description = "Allow TLS inbound traffic to ssh"
  vpc_id      = "${data.aws_vpc.selected.id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}