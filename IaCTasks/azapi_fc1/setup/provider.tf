terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.8.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "2.0.1"  
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azapi" {}


