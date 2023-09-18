variable "resourcegroup_name" {
  type        = string
  description = "The name of the resource group"
  default     = "rg-m.petrovic"
}


variable "location" {
  type        = string
  description = "The region for the deployment"
  default     = "West Europe"
}

variable "tags" {
  type        = map(string)
  description = "Tags used for the deployment"
  default = {
    "Environment" = "Lab"
    "Owner"       = "Milan"
  }
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
  default     = "aks-vega"
}

variable "keyvault_name" {
  type        = string
  description = "The name of the key vault to be created. The value will be randomly generated if blank."
  default     = "keyvault-vega"
}


variable "sku_name" {
  type        = string
  description = "The SKU of the vault to be created."
  default     = "standard"
  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "The sku_name must be one of the following: standard, premium."
  }
}


variable "key_permissions" {
  type        = list(string)
  description = "List of key permissions."
  default     = ["List", "Create", "Delete", "Get", "Purge", "Recover", "Update", "GetRotationPolicy", "SetRotationPolicy"]
}

variable "secret_permissions" {
  type        = list(string)
  description = "List of secret permissions."
  default     = ["Set"]
}
