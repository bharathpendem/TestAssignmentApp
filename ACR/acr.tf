resource "azurerm_container_registry" "cgidemo_acr" {
  name                     = var.var_acr_name
  resource_group_name      = var.var_acr_rg_name
  location                 = var.var_acr_location
  sku                      = var.var_sku
  admin_enabled            = true
}
