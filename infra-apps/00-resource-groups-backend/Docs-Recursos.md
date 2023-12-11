<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.3, < 1.4.0  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.0  |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource-groups"></a> [resource-groups](#module\_resource-groups) | git::ssh://git@ssh.dev.azure.com:/v3/ArquiteturaEstacio/Gibraltar - Plataforma/terraform-yduqs-modules//resource-groups | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.git_init](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Environment Variables | <pre>object({<br>    name            = string<br>    subscription_id = string<br>    tenant_id       = string<br>    location        = string<br><br><br><br>    vnet = object({<br>      virtual_network_name = string<br>      resource_group_name  = string<br>      range_network        = string<br>      num_ip               = string<br><br>    })<br><br>    tags = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project Variables | <pre>object({<br>    team     = string<br>    name     = string<br>    prefix   = string<br>    tags-dev = map(string)<br>    tags-qas = map(string)<br>    tags-prd = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_tgw"></a> [tgw](#input\_tgw) | Azure Variables | <pre>object({<br>    name            = string<br>    subscription_id = string<br>    tenant_id       = string<br><br>    vnet = object({<br>      virtual_network_name = string<br>      resource_group_name  = string<br>      location             = string<br>    })<br><br>    /**<br>     * Needs Private DNS Zone Contributor on rg azr-dns-zones in TGW subscription<br>    */<br>    dns_zones = object({<br>      resource_group_name = string<br>      location            = string<br>    })<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group |
<!-- END_TF_DOCS -->