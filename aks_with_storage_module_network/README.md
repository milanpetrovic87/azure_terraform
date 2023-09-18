## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.71.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.71.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_Storageaccount"></a> [Storageaccount](#module\_Storageaccount) | ./Storageaccount | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.cluster](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/kubernetes_cluster) | resource |
| [azurerm_resource_group.rgmpetrovic](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/resource_group) | resource |
| [azurerm_subnet.aks-default](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/subnet) | resource |
| [azurerm_virtual_network.aksvnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/virtual_network) | resource |
| [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster | `string` | `"aks-vega"` | no |
| <a name="input_key_permissions"></a> [key\_permissions](#input\_key\_permissions) | List of key permissions. | `list(string)` | <pre>[<br>  "List",<br>  "Create",<br>  "Delete",<br>  "Get",<br>  "Purge",<br>  "Recover",<br>  "Update",<br>  "GetRotationPolicy",<br>  "SetRotationPolicy"<br>]</pre> | no |
| <a name="input_keyvault_name"></a> [keyvault\_name](#input\_keyvault\_name) | The name of the key vault to be created. The value will be randomly generated if blank. | `string` | `"keyvault-vega"` | no |
| <a name="input_location"></a> [location](#input\_location) | The region for the deployment | `string` | `"West Europe"` | no |
| <a name="input_resourcegroup_name"></a> [resourcegroup\_name](#input\_resourcegroup\_name) | The name of the resource group | `string` | `"rg-m.petrovic"` | no |
| <a name="input_secret_permissions"></a> [secret\_permissions](#input\_secret\_permissions) | List of secret permissions. | `list(string)` | <pre>[<br>  "Set"<br>]</pre> | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU of the vault to be created. | `string` | `"standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags used for the deployment | `map(string)` | <pre>{<br>  "Environment": "Lab",<br>  "Owner": "Milan"<br>}</pre> | no |

## Outputs

No outputs.
