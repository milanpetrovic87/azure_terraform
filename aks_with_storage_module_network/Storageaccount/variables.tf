# variable "base_name" {
#     type = string
#     description = "Storage account base name"
  
# }

variable "resource_group_name" {
    type = string
    description = "Name of resource group"
    default     = "rgmpetrovic"
}


variable "location" {
    type = string
    description = "The location of deployment"
    default     = "West Europe"
}