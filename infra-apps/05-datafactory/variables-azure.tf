/**
 * Contem definicoes para consultar recursos da Azure alem das subscriptions do projeto
 *
 * Exemplo:
 * - Contem configuracoes especificas de Rede, DNS e firewall na Subscription TGW
 *
 * Estes parametros/variáveis são alimentados pelo arquivo: variables-azure.tfvars
*/

variable "tgw" {
  description = "Azure Variables"
  type = object({
    name            = string
    subscription_id = string
    tenant_id       = string

    vnet = object({
      virtual_network_name = string
      resource_group_name  = string
      location             = string
    })

    /**
     * Needs Private DNS Zone Contributor on rg azr-dns-zones in TGW subscription
    */
    dns_zones = object({
      resource_group_name = string
      location            = string
    })
  })
}


