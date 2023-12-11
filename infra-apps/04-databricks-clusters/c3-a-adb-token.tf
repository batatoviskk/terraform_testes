#----------------------------------------------------------------------------------------------------------------
# Create clusters on databricks workspace
#----------------------------------------------------------------------------------------------------------------

resource "null_resource" "obtem_token" {
  provisioner "local-exec" {
    command = "/bin/bash  ./tfvalida-adbw.sh  ${var.env.name} ${var.project.team}"
  }
}
