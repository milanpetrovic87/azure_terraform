output "StgActName" {
  value = module.Storageaccount.stg_act_name_out
}

output "RgName" {
  value = module.ResourceGroup.rg_name_out
}

output "out_container_name" {
  value = azurerm_storage_container.tfstate.name
}
