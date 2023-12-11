
module "resource-groups" {
  source = "git::ssh://git@ssh.dev.azure.com:/v3/ArquiteturaEstacio/Gibraltar - Plataforma/terraform-yduqs-modules//resource-groups"

  # Resource Group
  location            = var.env.location
  resource_group_name = "rg-gib${var.env.name}-${var.project.team}-${var.project.name}"
  tags                = var.env.name == "dev" ? var.project.tags-dev : var.env.name == "qas" ? var.project.tags-qas : var.project.tags-prd
}


