terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
    # subscription_id = var.subscription_id
    # client_secret   = var.client_secret
    # client_id       = var.client_id
    # tenant_id       = var.tenant_id
    features {}
}