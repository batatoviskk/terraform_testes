
variable "storage" {
  default     = true
  description = "deploy storage  or not?"
}

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
    storage      = string


  })
}


