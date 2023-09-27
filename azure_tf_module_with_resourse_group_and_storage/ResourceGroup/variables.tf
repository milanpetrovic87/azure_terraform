variable "base_name" {
    type = string
    description = "The base of the name for the resource group and storage account"
    default = "AKS-cluster"
}

variable "location" {
  type = string
  description = "The location of deployment"
  default = "West US"
}