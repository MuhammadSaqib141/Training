terraform {
  backend "azurerm" {
    resource_group_name = "saqib-rg-test"
    storage_account_name = "msstorageaccount00122234"
    container_name = "states"
    key = "prod.terraform.tfstate"   
  }
}