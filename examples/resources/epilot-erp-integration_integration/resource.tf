resource "epilot-erp-integration_integration" "my_integration" {
  access_token_ids = [
    "..."
  ]
  app_ids = [
    "..."
  ]
  connector_config = {
    auth = {
      api_key        = "...my_api_key..."
      api_key_header = "...my_api_key_header..."
      audience       = "...my_audience..."
      body_params = {
        key = "value"
      }
      client_id     = "...my_client_id..."
      client_secret = "...my_client_secret..."
      headers = {
        key = "value"
      }
      query_params = {
        key = "value"
      }
      resource  = "...my_resource..."
      scope     = "...my_scope..."
      token     = "...my_token..."
      token_url = "...my_token_url..."
      type      = "bearer"
    }
    base_url                  = "...my_base_url..."
    latest_types_package_name = "...my_latest_types_package_name..."
    latest_types_version      = "...my_latest_types_version..."
    types_versions = [
      {
        generated_at = "2022-07-16T09:39:09.198Z"
        generated_by = "...my_generated_by..."
        package_name = "...my_package_name..."
        status       = "deprecated"
        version      = "...my_version..."
      }
    ]
  }
  description        = "...my_description..."
  environment_config = "{ \"see\": \"documentation\" }"
  integration_type   = "erp"
  manifest = [
    "..."
  ]
  name      = "...my_name..."
  protected = false
  settings = {
    auto_refresh = {
      enabled                     = false
      freshness_threshold_minutes = 1
    }
    notifications = {
      default_channels = {
        email  = true
        in_app = true
      }
      digest = {
        channels = {
          email  = false
          in_app = true
        }
        day_of_week     = 0
        enabled         = true
        frequency       = "weekly"
        include_healthy = false
        skip_if_empty   = true
        time_of_day     = "...my_time_of_day..."
        timezone        = "...my_timezone..."
      }
      enabled = false
      monitored_codes = [
        "..."
      ]
      monitored_use_cases = [
        "..."
      ]
      mute_until = "2022-12-29T04:49:52.263Z"
      recipients = [
        {
          user_id = "...my_user_id..."
        }
      ]
      rules = [
        {
          channels = {
            email  = true
            in_app = false
          }
          codes = [
            "..."
          ]
          enabled            = true
          fallback_threshold = 5.59
          id                 = "...my_id..."
          min_sample_size    = 3
          name               = "...my_name..."
          quiet_period       = "...my_quiet_period..."
          sensitivity        = "medium"
          threshold = {
            two = "auto"
          }
          type   = "warning_threshold"
          window = "...my_window..."
        }
      ]
    }
  }
  use_cases = "{ \"see\": \"documentation\" }"
}