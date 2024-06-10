data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "default" {
  name     = "rg-301-p-dataplatform"
  location = var.location
}

resource "random_string" "random" {
  length           = 24
  special          = false
  min_lower = 10
  min_numeric = 5
  upper = false
}

resource "random_integer" "suffix" {
  min = 10000000
  max = 99999999
}