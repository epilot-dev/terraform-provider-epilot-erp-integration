# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "epilot-erp-integration_integration" "mine" {
  description = "test"
  name        = "hello world"
  id          ="9ff6abda-e954-4091-aecb-a74680824f4c"
  use_cases = [
    {
      inbound = {
        change_description = null
        configuration = {
          entities = [
            {
              enabled       = null
              entity_schema = "opportunity"
              fields = [
                {
                  attribute          = "opportunity_name"
                  constant           = null
                  enabled            = null
                  field              = "opportunity_name"
                  jsonata_expression = null
                  relation_refs      = null
                  relations          = null
                  type               = null
                },
              ]
              jsonata_expression = null
              unique_ids         = ["845bd96d-9ede-4646-a7f0-37b694b3614c"]
            },
          ]
          meter_readings = [
          ]
        }
        enabled = true
        name    = "metere"
        type    = "inbound"
      }
      outbound = null
    },
  ]
}
