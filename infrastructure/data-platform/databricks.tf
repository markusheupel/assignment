resource "azurerm_databricks_workspace" "default" {
  name                = "${random_string.random.id}"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  sku                 = "standard"
}