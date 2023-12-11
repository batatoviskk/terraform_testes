#----------------------------------------------------------------------------------------------------------------
# Commom configuration of  cluster for someone environment
#----------------------------------------------------------------------------------------------------------------
module "spark" {
  source = "git@ssh.dev.azure.com:/v3/ArquiteturaEstacio/Gibraltar - Plataforma/terraform-yduqs-modules//databricks-cluster"
  env    = var.env.name
}

