## Terraform module to install Terraform Provider binaries as overrides

###### Module Repository: https://github.com/plinde/terraform-provider-override-module
##### Module definition
```
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
```

##### Example use of Module
```
module "terraform-provider-statuscake_override" {
  source = "github.com/plinde/terraform-provider-override-module"

  binary_filename = "terraform-provider-statuscake"
  repo            = "plinde/terraform-provider-statuscake"
  release         = "v0.1.1-plinde-enhancements-pr2"
  arch            = "darwin-x86_64"
}
```

There may be other ways to accomplish the same goal (see `Makefile` and `direnv`)

```
git clone https://github.com/plinde/terraform-provider-statuscake.git ${GOPATH}/src/github.com/terraform-providers/terraform-provider-statuscake || true
cd "${GOPATH}/src/github.com/terraform-providers/terraform-provider-statuscake"
git checkout plinde-enhancements
go install
echo "built terraform-provider-statuscake from  ${GOPATH}/src/github.com/terraform-providers/terraform-provider-statuscake/terraform-provider-statuscake and placed in ${GOPATH}/bin/terraform-provider-statuscake"
ls -l ${GOPATH}/bin/terraform-provider-statuscake
  ```