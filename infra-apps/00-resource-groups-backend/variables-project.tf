variable "project" {
  description = "Project Variables"
  type = object({
    team     = string
    name     = string
    prefix   = string
    tags-dev = map(string)
    tags-qas = map(string)
    tags-prd = map(string)
  })
}
