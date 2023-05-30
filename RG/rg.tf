resource "azurerm_resource_group" "cgidemo-rg" {
  name     = var.var_resource_group_name
  location = var.location
}