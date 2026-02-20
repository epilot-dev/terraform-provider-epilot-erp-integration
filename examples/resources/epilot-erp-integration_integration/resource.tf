resource "epilot-erp-integration_integration" "my_integration" {
  access_token_ids = [
    "..."
  ]
  app_ids = [
    "..."
  ]
  description = "...my_description..."
  environment_config = [
    {
      description = "...my_description..."
      key         = "...my_key..."
      label       = "...my_label..."
      order       = 1
      required    = true
      type        = "SecretString"
    }
  ]
  name = "...my_name..."
  settings = {
    auto_refresh = {
      enabled                            = true
      freshness_threshold_minutes        = 1
      min_interval_between_syncs_minutes = 4
    }
  }
  use_cases = [
    {
      inbound = {
        change_description = "...my_change_description..."
        configuration = {
          entities = [
            {
              enabled = {
                str = "...my_str..."
              }
              entity_schema = "...my_entity_schema..."
              fields = [
                {
                  attribute = "...my_attribute..."
                  constant  = "{ \"see\": \"documentation\" }"
                  enabled = {
                    boolean = false
                  }
                  field              = "...my_field..."
                  jsonata_expression = "...my_jsonata_expression..."
                  relation_refs = {
                    items = [
                      {
                        entity_schema = "...my_entity_schema..."
                        path          = "...my_path..."
                        unique_ids = [
                          {
                            attribute          = "...my_attribute..."
                            constant           = "{ \"see\": \"documentation\" }"
                            field              = "...my_field..."
                            jsonata_expression = "...my_jsonata_expression..."
                            type               = "phone"
                          }
                        ]
                        value = {
                          attribute          = "...my_attribute..."
                          constant           = "{ \"see\": \"documentation\" }"
                          field              = "...my_field..."
                          jsonata_expression = "...my_jsonata_expression..."
                          operation          = "_append_all"
                        }
                      }
                    ]
                    jsonata_expression = "...my_jsonata_expression..."
                    operation          = "_append_all"
                  }
                  relations = {
                    items = [
                      {
                        entity_schema = "...my_entity_schema..."
                        tags = [
                          "..."
                        ]
                        unique_ids = [
                          {
                            attribute          = "...my_attribute..."
                            constant           = "{ \"see\": \"documentation\" }"
                            field              = "...my_field..."
                            jsonata_expression = "...my_jsonata_expression..."
                            type               = "email"
                          }
                        ]
                      }
                    ]
                    jsonata_expression = "...my_jsonata_expression..."
                    operation          = "_set"
                  }
                  type = "phone"
                }
              ]
              jsonata_expression = "...my_jsonata_expression..."
              mode               = "delete"
              scope = {
                query = [
                  {
                    attribute          = "...my_attribute..."
                    constant           = "{ \"see\": \"documentation\" }"
                    field              = "...my_field..."
                    jsonata_expression = "...my_jsonata_expression..."
                    type               = "phone"
                  }
                ]
                schema     = "...my_schema..."
                scope_mode = "query"
                unique_ids = [
                  {
                    attribute          = "...my_attribute..."
                    constant           = "{ \"see\": \"documentation\" }"
                    field              = "...my_field..."
                    jsonata_expression = "...my_jsonata_expression..."
                    type               = "email"
                  }
                ]
              }
              unique_ids = [
                "..."
              ]
            }
          ]
          meter_readings = [
            {
              fields = [
                {
                  attribute = "...my_attribute..."
                  constant  = "{ \"see\": \"documentation\" }"
                  enabled = {
                    boolean = true
                  }
                  field              = "...my_field..."
                  jsonata_expression = "...my_jsonata_expression..."
                  relation_refs = {
                    items = [
                      {
                        entity_schema = "...my_entity_schema..."
                        path          = "...my_path..."
                        unique_ids = [
                          {
                            attribute          = "...my_attribute..."
                            constant           = "{ \"see\": \"documentation\" }"
                            field              = "...my_field..."
                            jsonata_expression = "...my_jsonata_expression..."
                            type               = "phone"
                          }
                        ]
                        value = {
                          attribute          = "...my_attribute..."
                          constant           = "{ \"see\": \"documentation\" }"
                          field              = "...my_field..."
                          jsonata_expression = "...my_jsonata_expression..."
                          operation          = "_append"
                        }
                      }
                    ]
                    jsonata_expression = "...my_jsonata_expression..."
                    operation          = "_append_all"
                  }
                  relations = {
                    items = [
                      {
                        entity_schema = "...my_entity_schema..."
                        tags = [
                          "..."
                        ]
                        unique_ids = [
                          {
                            attribute          = "...my_attribute..."
                            constant           = "{ \"see\": \"documentation\" }"
                            field              = "...my_field..."
                            jsonata_expression = "...my_jsonata_expression..."
                            type               = "phone"
                          }
                        ]
                      }
                    ]
                    jsonata_expression = "...my_jsonata_expression..."
                    operation          = "_append_all"
                  }
                  type = "email"
                }
              ]
              jsonata_expression = "...my_jsonata_expression..."
              meter = {
                unique_ids = [
                  {
                    attribute          = "...my_attribute..."
                    constant           = "{ \"see\": \"documentation\" }"
                    field              = "...my_field..."
                    jsonata_expression = "...my_jsonata_expression..."
                    type               = "email"
                  }
                ]
              }
              meter_counter = {
                unique_ids = [
                  {
                    attribute          = "...my_attribute..."
                    constant           = "{ \"see\": \"documentation\" }"
                    field              = "...my_field..."
                    jsonata_expression = "...my_jsonata_expression..."
                    type               = "phone"
                  }
                ]
              }
              mode             = "upsert"
              reading_matching = "strict-date"
              scope = {
                source = "...my_source..."
              }
            }
          ]
        }
        enabled = true
        id      = "f21f5505-531e-48a5-bb28-64853db4e487"
        name    = "...my_name..."
        type    = "inbound"
      }
    }
  ]
}