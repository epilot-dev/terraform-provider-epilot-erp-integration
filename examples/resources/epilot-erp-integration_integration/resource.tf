resource "epilot-erp-integration_integration" "my_integration" {
  access_token_ids = [
    "..."
  ]
  description = "...my_description..."
  name        = "...my_name..."
  use_cases = [
    {
      outbound = {
        change_description = "...my_change_description..."
        configuration = {
          event_catalog_event = "contract.created"
          mappings = [
            {
              created_at = "2022-06-02T04:05:14.534Z"
              delivery = {
                type         = "webhook"
                webhook_id   = "...my_webhook_id..."
                webhook_name = "...my_webhook_name..."
                webhook_url  = "...my_webhook_url..."
              }
              enabled            = false
              id                 = "bfd4bcb8-1d02-4b3b-a2a9-0fee857c42f2"
              jsonata_expression = "{ \"id\": entity._id, \"customer\": entity.customer_name }"
              name               = "ERP Contract Sync"
              updated_at         = "2022-02-21T23:55:34.826Z"
            }
          ]
        }
        enabled = true
        id      = "eb4ac4d2-540e-4705-aba9-48085a4461e0"
        name    = "...my_name..."
        type    = "outbound"
      }
    }
  ]
}