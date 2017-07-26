# terraform apply -target=null_resource.terraform-provider-statuscake-binary

resource "null_resource" "terraform-provider-statuscake-binary" {
  triggers {
    # use this to trigger on every run
    uuid_autotrigger = "${uuid()}"
  }

  provisioner "local-exec" {
    command = "curl -s -L ${data.template_file.path-to-binary.rendered} -o ${var.binary_filename} && chmod u+x ${var.binary_filename}"
  }
}
