
resource "azurerm_application_insights" "ai" {
  name                = "appinsights-vega"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  application_type    = "web"
  depends_on = [ azurerm_resource_group.aks_rg ]
}
