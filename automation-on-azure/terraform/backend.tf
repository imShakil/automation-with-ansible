terraform {
  backend "azurerm" {
    storage_account_name = "tfstateinbackend"
    resource_group_name  = "tfstate-rg"
    container_name       = "tfstate"
    key                  = "adhoc151025.terraform.tfstate"
  }
}
