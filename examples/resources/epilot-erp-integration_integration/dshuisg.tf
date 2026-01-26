# epilot-erp-integration_integration.mine:
resource "epilot-erp-integration_integration" "mine" {
    created_at  = "2026-01-26T15:53:31.349Z"
    description = "tada"
    id          = "eb027d15-cff0-4919-8516-955501c1637f"
    name        = "Tadaaaaaa integration"
    org_id      = "66"
    updated_at  = "2026-01-26T15:53:31.349Z"
    use_cases   = [
        {
            inbound = {
                configuration  = {
                    entities       = [
                        {
                            enabled       = {
                                boolean = true
                            }
                            entity_schema = "contact"
                            fields        = [
                                {
                                    attribute          = "external_id"
                                    jsonata_expression = "customer.customerId"
                                },
                                {
                                    attribute          = "full_name"
                                    jsonata_expression = "customer.name"
                                },
                                {
                                    attribute          = "email"
                                    jsonata_expression = <<-EOT
                                        $exists(customer.email) and customer.email != '' ? [
                                          {
                                            "_tags": ["Primary"],
                                            "email": customer.email
                                          }
                                        ] : undefined
                                    EOT
                                },
                                {
                                    attribute          = "phone"
                                    jsonata_expression = <<-EOT
                                        $exists(customer.phone) and customer.phone != '' ? [
                                          {
                                            "_tags": ["Primary"],
                                            "phone": customer.phone
                                          }
                                        ] : undefined
                                    EOT
                                },
                            ]
                            unique_ids    = [
                                "external_id",
                            ]
                        },
                        {
                            enabled       = {
                                boolean = true
                            }
                            entity_schema = "order"
                            fields        = [
                                {
                                    attribute = "external_id"
                                    field     = "orderId"
                                },
                                {
                                    attribute = "order_number"
                                    field     = "orderId"
                                },
                                {
                                    attribute = "order_date"
                                    field     = "orderDate"
                                },
                                {
                                    attribute = "status"
                                    field     = "status"
                                },
                                {
                                    attribute          = "total_amount_decimal"
                                    jsonata_expression = "$exists(totalAmount) ? $formatNumber($number(totalAmount), '#0.00') : '0.00'"
                                },
                                {
                                    attribute          = "total_amount"
                                    jsonata_expression = "$exists(totalAmount) ? $string($round($number(totalAmount) * 100)) : '0'"
                                },
                                {
                                    attribute = "total_amount_currency"
                                    field     = "currency"
                                },
                                {
                                    attribute          = "delivery_date"
                                    jsonata_expression = <<-EOT
                                        (
                                          $date := deliveryDate;
                                          $exists($date) and $date != '' ? $date : undefined
                                        )
                                    EOT
                                },
                                {
                                    attribute          = "shipping_address"
                                    jsonata_expression = <<-EOT
                                        (
                                          $shippingAddr := shippingAddress;
                                          $exists($shippingAddr) ? [
                                            {
                                              "street": $shippingAddr.street,
                                              "postal_code": $exists($shippingAddr.postalCode) ? $string($shippingAddr.postalCode) : undefined,
                                              "city": $shippingAddr.city,
                                              "country": $shippingAddr.country
                                            }
                                          ] : undefined
                                        )
                                    EOT
                                },
                                {
                                    attribute          = "order_items"
                                    jsonata_expression = <<-EOT
                                        (
                                          $items := items;
                                          $exists($items) and $count($items) > 0 ? $items.{
                                            "_tags": [productId],
                                            "product_id": productId,
                                            "product_name": productName,
                                            "quantity": $string(quantity),
                                            "unit_price": $formatNumber($number(unitPrice), '#0.00'),
                                            "total_price": $formatNumber($number(totalPrice), '#0.00')
                                          } : undefined
                                        )
                                    EOT
                                },
                                {
                                    attribute          = "item_count"
                                    jsonata_expression = "$count(items)"
                                },
                                {
                                    attribute = "customer"
                                    relations = {
                                        items     = [
                                            {
                                                entity_schema = "contact"
                                                tags          = []
                                                unique_ids    = [
                                                    {
                                                        attribute          = "external_id"
                                                        jsonata_expression = "customer.customerId"
                                                    },
                                                ]
                                            },
                                        ]
                                        operation = "_set"
                                    }
                                },
                            ]
                            unique_ids    = [
                                "external_id",
                            ]
                        },
                    ]
                    meter_readings = []
                }
                created_at     = "2026-01-26T15:54:40.667Z"
                enabled        = true
                id             = "89a75a22-928c-48f4-800c-5fca9b56df3c"
                integration_id = "eb027d15-cff0-4919-8516-955501c1637f"
                name           = "metereddsd"
                type           = "inbound"
                updated_at     = "2026-01-26T15:54:40.667Z"
            }
        },
        {
            outbound = {
                configuration  = {
                    "key" = "\"value\""
                }
                created_at     = "2026-01-26T15:53:31.545Z"
                enabled        = true
                id             = "b8032f80-be43-4071-85f2-a39d6607841c"
                integration_id = "eb027d15-cff0-4919-8516-955501c1637f"
                name           = "Tadaaaaaa integration"
                type           = "outbound"
                updated_at     = "2026-01-26T15:53:31.545Z"
            }
        },
    ]
}
