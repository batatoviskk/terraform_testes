variable "env" {
  description = "Environment Variables"
  type = object({
    name            = string
    subscription_id = string
    tenant_id       = string
    location        = string



    vnet = object({
      virtual_network_name = string
      resource_group_name  = string
      range_network        = string
      num_ip               = string

    })

    tags = map(string)
  })

  validation {
    condition     = can(contains(["dev", "qas", "prd"], var.env.name))
    error_message = "Invalid environment provided: must be dev, qas, or prd."
  }

  validation {
    condition = can(
      var.env.name != "dev" ? var.env.location == "eastus" :
      contains(["eastus", "southcentralus", "westus2", "northcentralus"], var.env.name) # brasilsouth: will not work because is not clean sheet
    )
    error_message = "Invalid region provided: must be eastus for prd/qas."
  }
}

