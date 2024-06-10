resource "azurerm_stream_analytics_cluster" "default" {
  name                = "streamingdatacluster"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  streaming_capacity  = 36
}

/* resource "azurerm_stream_analytics_job" "taxistream" {
  name                                     = "taxi-stream-job"
  resource_group_name                      = azurerm_resource_group.default.name
  location                                 = azurerm_resource_group.default.location
  compatibility_level                      = "1.2"
  data_locale                              = "en-GB"
  events_late_arrival_max_delay_in_seconds = 60
  events_out_of_order_max_delay_in_seconds = 50
  events_out_of_order_policy               = "Adjust"
  output_error_policy                      = "Drop"
  streaming_units                          = 3

  tags = {
    environment = "Example"
  }

  transformation_query = <<QUERY
    SELECT *
    INTO [YourOutputAlias]
    FROM [YourInputAlias]
QUERY

} */

/* resource "azurerm_stream_analytics_stream_input_iothub" "default" {
  name                         = "taxi-stream-input"
  stream_analytics_job_name    = data.azurerm_stream_analytics_job.taxistream.name
  resource_group_name          = data.azurerm_stream_analytics_job.taxistream.resource_group_name
  endpoint                     = "messages/events"
  eventhub_consumer_group_name = "$Default"
  iothub_namespace             = azurerm_iothub.default.name
  shared_access_policy_key     = azurerm_iothub.default.shared_access_policy[0].primary_key
  shared_access_policy_name    = "iothubowner"

  serialization {
    type     = "Json"
    encoding = "UTF8"
  }
} */