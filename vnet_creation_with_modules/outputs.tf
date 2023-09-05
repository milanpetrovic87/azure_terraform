output "azurerm_subnet_id" {
  value = {
    for id in keys(var.subnets) : id => azurerm_subnet.subnet[id].id
  }
  description = "List the ID's of the subnets"
}

output "bastion_public_ip" {
  value       = azurerm_public_ip.bastion_public_ip.ip_address
  description = "List of public IP of the bastion server"
}

