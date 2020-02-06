resource "aws_eip" "web_eip" {
	instance = "${aws_instance.web.id}"
	tags = {
		Name = "${var.project_name}-eip"
	}
}