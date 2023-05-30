output "admin_username" {
  value = azurerm_container_registry.cgidemo_acr.admin_username
}
output "admin_password" {
  value = azurerm_container_registry.cgidemo_acr.admin_password
  sensitive = true
}
output "login_server" {
  value = azurerm_container_registry.cgidemo_acr.login_server
}