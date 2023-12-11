#----------------------------------------------------------------------------------------------------------------
# Repositorio. 
#----------------------------------------------------------------------------------------------------------------
locals {
  #git_repo   = "https://ArquiteturaEstacio@dev.azure.com/ArquiteturaEstacio/Gibraltar%20-%20Plataforma/_git/bidatabricks-${var.project.team}"
  git_name_team = title("${var.project.team}")
  git_repo      = "https://arquiteturaestacio.visualstudio.com/Gibraltar-${local.git_name_team}/_git/bidatabricks"

  git_branch = var.env.name == "prd" ? "main" : var.env.name
  repo_dir   = "/Repos/Data_Eng"
  git_path   = "/Repos/Data_Eng/bidatabricks-${var.project.team}"
}

resource "databricks_directory" "dir_git_repos" {
  path             = local.repo_dir
  delete_recursive = true

  lifecycle {
    create_before_destroy = true
  }


  depends_on = [
    module.spark,
    databricks_cluster.team,
    data.azurerm_databricks_workspace.dbw,
    null_resource.obtem_token
  ]


}

resource "databricks_repo" "git_repo_branch" {

  git_provider = "azureDevOpsServices"
  url          = local.git_repo
  branch       = local.git_branch

  path = local.git_path
  # path = databricks_directory.dir_git_repos.path

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    databricks_directory.dir_git_repos,
  ]
}


