data "template_file" "init" {
  template = "${file("user-data.txt")}"
  vars = {
    project_name = "${var.project_name}"
  }
}