provider "azurerm" {
  features {}
}
terraform {
    backend "azurerm" {
        resource_group_name = "terraformrg"
        storage_account_name = "terraformstorageaccoun"
        container_name = "terraform"
        key = "terraform.tfstate"
    }
}
resource "azurerm_resource_group" "lab1rg" {
  name     = "lab1rg"
  location = "eastus2"
}

resource "azurerm_mssql_server" "lab1sqlsrv" {
  name                         = "sqlsrver2205"
  resource_group_name          = azurerm_resource_group.lab1rg.name
  location                     = azurerm_resource_group.lab1rg.location
  version                      = "12.0"
  administrator_login          = "techadmin"
  administrator_login_password = "Challengelab123$"
}

resource "azurerm_mssql_database" "lab1sqldb" {
  name           = "sqldblab12205"
  server_id      = azurerm_mssql_server.lab1sqlsrv.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "BC_Gen5_2"
  zone_redundant = true

}
