# terraform apply -target=null_resource.terraform-provider-statuscake-binary
resource "null_resource" "terraform-provider-statuscake-binary" {
  triggers {
    # no sense pulling the same binary on each subsequent run
    sha1 = "${sha1("${file("terraform-provider-statuscake")}")}"
  }

  provisioner "local-exec" {
    command = "curl -s -L ${data.template_file.path-to-binary.rendered} -o ${var.binary_filename} && chmod u+x ${var.binary_filename}"
  }
}
