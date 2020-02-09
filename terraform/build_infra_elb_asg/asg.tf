resource "aws_autoscaling_group" "web" {
  name                      = "${var.project_name}-web"
  max_size                  = 5
  min_size                  = 0
  desired_capacity          = 3
  health_check_grace_period = 10
  health_check_type         = "ELB"

  load_balancers = [
    "${aws_elb.web.name}"
  ]

  launch_configuration = "${aws_launch_configuration.web.name}"
  vpc_zone_identifier  = "${data.aws_subnet_ids.selected.ids}"

  tag {
    key                 = "Name"
    value               = "${var.project_name}-web-asg"
    propagate_at_launch = true
  }
}