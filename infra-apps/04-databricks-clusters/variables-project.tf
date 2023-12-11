variable "project" {
  description = "Project Variables"
  type = object({
    team         = string
    name         = string
    prefix       = string
    rg_to_global = string
    tags-dev     = map(string)
    tags-qas     = map(string)
    tags-prd     = map(string)
  })
}



# variable "network" {
#   description = "The name of the vnet/subnet where the resources are created"
#   type = object({
#     subnet_id = string
#   })
# }

# variable "network_subnet_ids" {
#   description = "The name of the subnet allowed to comunicate"
#   type        = list(string)
#   default     = []
# }

# variable "dns_zones" {
#   description = "The hub subscription/resource group with dns zones for dns fowarding"
#   type = object({
#     resource_group_name = string
#     subscription_id     = string
#   })
# }
