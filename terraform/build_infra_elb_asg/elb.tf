resource "aws_elb" "web" {
  name            = "${var.project_name}-elb-web"
  subnets         = "${data.aws_subnet_ids.selected.ids}"
  security_groups = ["${aws_security_group.allow_ssh_http_anywhere.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 2
    target              = "HTTP:80/"
    interval            = 5
  }

  tags = {
    Name = "${var.project_name}-elb-web"
  }
}
