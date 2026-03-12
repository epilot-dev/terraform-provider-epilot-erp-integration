resource "epilot-erp-integration_integration" "my_integration" {
  access_token_ids = [
    "..."
  ]
  app_ids = [
    "..."
  ]
  description        = "...my_description..."
  environment_config = "{ \"see\": \"documentation\" }"
  name               = "...my_name..."
  settings = {
    auto_refresh = {
      enabled                     = true
      freshness_threshold_minutes = 1
    }
  }
  use_cases = "{ \"see\": \"documentation\" }"
}