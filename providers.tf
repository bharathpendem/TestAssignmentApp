terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.33.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "CloudConnect"
      storage_account_name = "cloudconnectcgi"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  client_id = var.var_client_id
  client_secret = var.var_client_secret
  tenant_id = var.var_tenant_id
  subscription_id = var.var_subscription_id
}