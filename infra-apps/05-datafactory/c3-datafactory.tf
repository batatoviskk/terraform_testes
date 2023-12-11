module "adf" {
  source = "git@ssh.dev.azure.com:/v3/ArquiteturaEstacio/Gibraltar - Plataforma/terraform-yduqs-modules//datafactory"

  datafactory_name    = join("-", ["${var.project.prefix}", "gib${var.env.name}", "${var.project.team}"])
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.env.location

  vsts = {
    tenant_id       = data.azurerm_client_config.current.tenant_id
    account_name    = "ArquiteturaEstacio"
    project_name    = "Gibraltar - Plataforma"
    repository_name = join("-", ["bidatafactory", "${var.project.team}"])
    branch_name     = var.env.name
    root_folder     = "/"
    #publish_branch  = "adf_publish"
  }

  tags = var.env.name == "dev" ? var.project.tags-dev : var.env.name == "qas" ? var.project.tags-qas : var.project.tags-prd
}

