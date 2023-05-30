resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.var_aks_name
  location            = var.location
  resource_group_name = var.var_aks_resource_group_name
  dns_prefix          = var.var_dns_prefix
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size = var.var_vm_size
  }

  service_principal {
    client_id     = var.var_client_id
    client_secret = var.var_client_secret
  }

  tags = {
    environment = "Demo"
    CreatedBy = "Bharath"
  }
}

