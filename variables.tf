variable "binary_filename" {}
variable "repo" {}
variable "release" {}
variable "arch" {}

data "template_file" "path-to-binary" {
  template = "https://github.com/$${repo}/releases/download/$${release}/$${binary_filename}-$${arch}"

  vars {
    repo            = "${var.repo}"
    release         = "${var.release}"
    arch            = "${var.arch}"
    binary_filename = "${var.binary_filename}"
  }
}
