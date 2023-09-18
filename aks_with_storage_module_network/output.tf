resource "local_file" "kubeconfig" {
  depends_on = [azurerm_kubernetes_cluster.cluster]
  filename   = "kubeconfig"
  content    = azurerm_kubernetes_cluster.cluster.kube_config_raw
}

# output "storage_account_name" {
#   value = azurerm_storage_account.tfstate.name
# }

# output "storage_container_name" {
#   value = azurerm_storage_container.tfstate.name
# }