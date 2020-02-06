resource "aws_key_pair" "keypair" {
  key_name   = "${var.project_name}-keypair"
  public_key = "***"
}
