<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.3, < 1.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.50.0 |
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | 1.14.1 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_spark"></a> [spark](#module\_spark) | git@ssh.dev.azure.com:/v3/ArquiteturaEstacio/Gibraltar - Plataforma/terraform-yduqs-modules//databricks-cluster | n/a |

## Resources

| Name | Type |
|------|------|
| [databricks_cluster.team](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/cluster) | resource |
| [databricks_directory.dir_git_repos](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/directory) | resource |
| [databricks_repo.git_repo_branch](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/repo) | resource |
| [null_resource.obtem_token](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_databricks_workspace.dbw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/databricks_workspace) | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subscription.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet_root](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Environment Variables | <pre>object({<br>    name            = string<br>    subscription_id = string<br>    tenant_id       = string<br>    location        = string<br><br><br><br>    vnet = object({<br>      virtual_network_name = string<br>      resource_group_name  = string<br>      range_network        = string<br>      num_ip               = string<br><br>    })<br><br>    tags = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project Variables | <pre>object({<br>    team         = string<br>    name         = string<br>    prefix       = string<br>    rg_to_global = string<br>    tags-dev     = map(string)<br>    tags-qas     = map(string)<br>    tags-prd     = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_tgw"></a> [tgw](#input\_tgw) | Azure Variables | <pre>object({<br>    name            = string<br>    subscription_id = string<br>    tenant_id       = string<br><br>    vnet = object({<br>      virtual_network_name = string<br>      resource_group_name  = string<br>      location             = string<br>    })<br><br>    /**<br>     * Needs Private DNS Zone Contributor on rg azr-dns-zones in TGW subscription<br>    */<br>    dns_zones = object({<br>      resource_group_name = string<br>      location            = string<br>    })<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_databricks_id"></a> [databricks\_id](#output\_databricks\_id) | n/a |
| <a name="output_databricks_workspace_id"></a> [databricks\_workspace\_id](#output\_databricks\_workspace\_id) | n/a |
| <a name="output_databricks_workspace_url"></a> [databricks\_workspace\_url](#output\_databricks\_workspace\_url) | n/a |
<!-- END_TF_DOCS -->