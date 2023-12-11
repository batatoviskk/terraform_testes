<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.3, < 1.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.46.0 |
| <a name="provider_azurerm.tgw"></a> [azurerm.tgw](#provider\_azurerm.tgw) | 3.46.0 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.9.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_storage"></a> [storage](#module\_storage) | git@ssh.dev.azure.com:/v3/ArquiteturaEstacio/Gibraltar - Plataforma/terraform-yduqs-modules//storage | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_private_endpoint.endpoint_dfs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_storage_container.stg_config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_data_lake_gen2_filesystem.stg_gen2fs_bronze](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_filesystem) | resource |
| [azurerm_storage_encryption_scope.crypto_config_scope](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_encryption_scope) | resource |
| [time_sleep.role_assignment_sleep](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_private_dns_zone.dns_zone_blob](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.dns_zone_dfs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.lake](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.snet-adfir](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.snet-dbw-ext](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.snet-dbw-int](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.snet-lake](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.snet-svc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet_root](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Environment Variables | <pre>object({<br>    name            = string<br>    subscription_id = string<br>    tenant_id       = string<br>    location        = string<br><br><br><br>    vnet = object({<br>      virtual_network_name = string<br>      resource_group_name  = string<br>      range_network        = string<br>      num_ip               = string<br><br>    })<br><br>    tags = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project Variables | <pre>object({<br>    team         = string<br>    name         = string<br>    prefix       = string<br>    rg_to_global = string<br>    tags-dev     = map(string)<br>    tags-qas     = map(string)<br>    tags-prd     = map(string)<br>    storage      = string<br><br><br>  })</pre> | n/a | yes |
| <a name="input_storage"></a> [storage](#input\_storage) | deploy storage  or not? | `bool` | `true` | no |
| <a name="input_tgw"></a> [tgw](#input\_tgw) | Azure Variables | <pre>object({<br>    name            = string<br>    subscription_id = string<br>    tenant_id       = string<br><br>    vnet = object({<br>      virtual_network_name = string<br>      resource_group_name  = string<br>      location             = string<br>    })<br><br>    /**<br>     * Needs Private DNS Zone Contributor on rg azr-dns-zones in TGW subscription<br>    */<br>    dns_zones = object({<br>      resource_group_name = string<br>      location            = string<br>    })<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->