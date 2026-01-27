# epilot-erp-integration_integration.integration_74a4aa68b35c4570be8aa15315b13b01:
resource "epilot-erp-integration_integration" "integration_74a4aa68b35c4570be8aa15315b13b01" {
  lifecycle {
    prevent_destroy = true
  }
  description = ""
  name        = "Schleupenssssss TEST"
  use_cases = [
    {
      inbound = {
        change_description = "Configuration updated"
        configuration = {
          entities = [
            {
              enabled = {
                boolean = true
              }
              entity_schema = "contact"
              fields = [
                {
                  attribute = "external_id"
                  field     = "customerId"
                },
                {
                  attribute          = "first_name"
                  jsonata_expression = "$exists(firstName) and firstName != '' ? firstName : undefined"
                },
                {
                  attribute = "last_name"
                  field     = "lastName"
                },
                {
                  attribute          = "company_name"
                  jsonata_expression = "customerType = 'business' ? companyName : undefined"
                },
                {
                  attribute = "customer_type"
                  field     = "customerType"
                },
                {
                  attribute          = "tax_id"
                  jsonata_expression = "$exists(taxId) and taxId != '' ? taxId : undefined"
                },
                {
                  attribute = "status"
                  field     = "status"
                },
                {
                  attribute          = "full_name"
                  jsonata_expression = "customerType = 'business' ? companyName : (firstName & ' ' & lastName)"
                },
                {
                  attribute          = "email"
                  jsonata_expression = <<-EOT
                                        (
                                          $mainEmail := $exists(email) and email != '' ? [
                                            {
                                              "_tags": ["Primary"],
                                              "email": email
                                            }
                                          ] : [];
                                          $count($mainEmail) > 0 ? $mainEmail : undefined
                                        )
                                    EOT
                },
                {
                  attribute          = "phone"
                  jsonata_expression = <<-EOT
                                        (
                                          $mainPhone := $exists(phone) and phone != '' ? [
                                            {
                                              "_tags": ["Primary"],
                                              "phone": phone
                                            }
                                          ] : [];
                                          
                                          $mobilePhone := $exists(mobile) and mobile != '' ? [
                                            {
                                              "_tags": ["Mobile"],
                                              "phone": mobile
                                            }
                                          ] : [];
                                          
                                          $allPhones := $append($mainPhone, $mobilePhone);
                                          $count($allPhones) > 0 ? $allPhones : undefined
                                        )
                                    EOT
                },
                {
                  attribute          = "address"
                  jsonata_expression = <<-EOT
                                        (
                                          $mainAddress := $exists(address) ? [
                                            {
                                              "_tags": ["Primary Address"],
                                              "street": address.street,
                                              "postal_code": $exists(address.postalCode) ? $string(address.postalCode) : undefined,
                                              "city": address.city,
                                              "country": address.country
                                            }
                                          ] : [];
                                          
                                          $billingAddr := $exists(billingAddress) and billingAddress.street != '' ? [
                                            {
                                              "_tags": ["Billing Address"],
                                              "street": billingAddress.street,
                                              "postal_code": $exists(billingAddress.postalCode) ? $string(billingAddress.postalCode) : undefined,
                                              "city": billingAddress.city,
                                              "country": billingAddress.country
                                            }
                                          ] : [];
                                          
                                          $allAddresses := $append($mainAddress, $billingAddr);
                                          $count($allAddresses) > 0 ? $allAddresses : undefined
                                        )
                                    EOT
                },
                {
                  attribute = "account"
                  relations = {
                    items = [
                      {
                        entity_schema = "account"
                        tags          = []
                        unique_ids = [
                          {
                            attribute          = "customer_number"
                            jsonata_expression = "customerId"
                          },
                        ]
                      },
                    ]
                    operation = "_set"
                  }
                },
              ]
              unique_ids = [
                "external_id",
              ]
            },
            {
              enabled = {
                boolean = true
              }
              entity_schema = "account"
              fields = [
                {
                  attribute = "customer_number"
                  field     = "customerId"
                },
                {
                  attribute = "name"
                  field     = "companyName"
                },
                {
                  attribute          = "tax_id"
                  jsonata_expression = "$exists(taxId) and taxId != '' ? taxId : undefined"
                },
                {
                  attribute          = "website"
                  jsonata_expression = "$exists(account.website) and account.website != '' ? account.website : undefined"
                },
                {
                  attribute          = "industry"
                  jsonata_expression = "$exists(account.industry) ? account.industry : undefined"
                },
                {
                  attribute          = "company_size"
                  jsonata_expression = "$exists(account.companySize) ? account.companySize : undefined"
                },
                {
                  attribute          = "email"
                  jsonata_expression = <<-EOT
                                        (
                                          $mainEmail := $exists(email) and email != '' ? [
                                            {
                                              "_tags": ["Primary"],
                                              "email": email
                                            }
                                          ] : [];
                                          $count($mainEmail) > 0 ? $mainEmail : undefined
                                        )
                                    EOT
                },
                {
                  attribute          = "phone"
                  jsonata_expression = <<-EOT
                                        (
                                          $mainPhone := $exists(phone) and phone != '' ? [
                                            {
                                              "_tags": ["Primary"],
                                              "phone": phone
                                            }
                                          ] : [];
                                          
                                          $mobilePhone := $exists(mobile) and mobile != '' ? [
                                            {
                                              "_tags": ["Mobile"],
                                              "phone": mobile
                                            }
                                          ] : [];
                                          
                                          $allPhones := $append($mainPhone, $mobilePhone);
                                          $count($allPhones) > 0 ? $allPhones : undefined
                                        )
                                    EOT
                },
                {
                  attribute          = "address"
                  jsonata_expression = <<-EOT
                                        (
                                          $mainAddress := $exists(address) ? [
                                            {
                                              "_tags": ["Primary Address"],
                                              "street": address.street,
                                              "postal_code": $exists(address.postalCode) ? $string(address.postalCode) : undefined,
                                              "city": address.city,
                                              "country": address.country
                                            }
                                          ] : [];
                                          
                                          $billingAddr := $exists(billingAddress) and billingAddress.street != '' ? [
                                            {
                                              "_tags": ["Billing Address"],
                                              "street": billingAddress.street,
                                              "postal_code": $exists(billingAddress.postalCode) ? $string(billingAddress.postalCode) : undefined,
                                              "city": billingAddress.city,
                                              "country": billingAddress.country
                                            }
                                          ] : [];
                                          
                                          $allAddresses := $append($mainAddress, $billingAddr);
                                          $count($allAddresses) > 0 ? $allAddresses : undefined
                                        )
                                    EOT
                },
                {
                  attribute          = "payment"
                  jsonata_expression = <<-EOT
                                        (
                                          $hasPayment := $exists(defaultPayment) and $exists(defaultPayment.iban) and defaultPayment.iban != '';
                                          $payment := $hasPayment ? [
                                            {
                                              "type": "payment_sepa",
                                              "data": {
                                                "iban": defaultPayment.iban,
                                                "bic_number": $exists(defaultPayment.bic) ? defaultPayment.bic : undefined,
                                                "fullname": companyName
                                              }
                                            }
                                          ] : [];
                                          $count($payment) > 0 ? $payment : undefined
                                        )
                                    EOT
                },
                {
                  attribute = "contacts"
                  relations = {
                    items = [
                      {
                        entity_schema = "contact"
                        tags          = []
                        unique_ids = [
                          {
                            attribute          = "external_id"
                            jsonata_expression = "customerId"
                          },
                        ]
                      },
                    ]
                    operation = "_set"
                  }
                },
              ]
              unique_ids = [
                "customer_number",
              ]
            },
            {
              enabled = {
                boolean = true
              }
              entity_schema = "billing_account"
              fields = [
                {
                  attribute = "external_id"
                  field     = "customerId"
                },
                {
                  attribute = "billing_account_number"
                  field     = "customerId"
                },
                {
                  attribute          = "billing_address"
                  jsonata_expression = <<-EOT
                                        $exists(billingAddress) ? {
                                          "_tags": ["Billing"],
                                          "street": billingAddress.street,
                                          "postal_code": $exists(billingAddress.postalCode) ? $string(billingAddress.postalCode) : undefined,
                                          "city": billingAddress.city,
                                          "country": billingAddress.country
                                        } : undefined
                                    EOT
                },
                {
                  attribute          = "payment_method"
                  jsonata_expression = <<-EOT
                                        (
                                          $hasPayment := $exists(defaultPayment) and $exists(defaultPayment.iban) and defaultPayment.iban != '';
                                          $payment := $hasPayment ? [
                                            {
                                              "type": "payment_sepa",
                                              "data": {
                                                "iban": defaultPayment.iban,
                                                "bic_number": $exists(defaultPayment.bic) ? defaultPayment.bic : undefined,
                                                "fullname": companyName
                                              }
                                            }
                                          ] : [];
                                          $count($payment) > 0 ? $payment : undefined
                                        )
                                    EOT
                },
                {
                  attribute = "billing_contact"
                  relations = {
                    items = [
                      {
                        entity_schema = "contact"
                        tags          = []
                        unique_ids = [
                          {
                            attribute          = "external_id"
                            jsonata_expression = "customerId"
                          },
                        ]
                      },
                    ]
                    operation = "_set"
                  }
                },
              ]
              unique_ids = [
                "external_id",
              ]
            },
          ]
          meter_readings = []
        }
        enabled        = true
        name           = "CustomerCreated"
        type           = "inbound"
      }
    },
    {
      inbound = {
        change_description = "break jsonata"
        configuration = {
          entities = [
            {
              enabled = {
                boolean = true
              }
              entity_schema = "contact"
              fields = [
                {
                  attribute = "external_id"
                  field     = "customerId"
                },
                {
                  attribute          = "first_name"
                  jsonata_expression = "$exists(firstName) and firstName != '' ? firstName : undefined"
                },
                {
                  attribute = "last_name"
                  field     = "lastName"
                },
                {
                  attribute          = "company_name"
                  jsonata_expression = "customerType = 'business' ? companyName : undefined"
                },
                {
                  attribute = "customer_type"
                  field     = "customerType"
                },
                {
                  attribute          = "tax_id"
                  jsonata_expression = "$exists(taxId) and taxId != '' ? taxId : undefined"
                },
                {
                  attribute = "status"
                  field     = "status"
                },
                {
                  attribute          = "full_name"
                  jsonata_expression = "customerType = 'business' ? companyName : (firstName & ' ' & lastName)"
                },
                {
                  attribute          = "email"
                  jsonata_expression = <<-EOT
                                        (
                                          $mainEmail := $exists(email) and email != '' ? [
                                            {
                                              "_tags": ["Primary"],
                                              "email": email
                                            }
                                          ] : [];
                                          $count($mainEmail) > 0 ? $mainEmail : undefined
                                        )
                                    EOT
                },
                {
                  attribute          = "phone"
                  jsonata_expression = <<-EOT
                                        (
                                          $mainPhone := $exists(phone) and phone != '' ? [
                                            {
                                              "_tags": ["Primary"],
                                              "phone": phone
                                            }
                                          ] : [];
                                          
                                          $mobilePhone := $exists(mobile) and mobile != '' ? [
                                            {
                                              "_tags": ["Mobile"],
                                              "phone": mobile
                                            }
                                          ] : [];
                                          
                                          $allPhones := $append($mainPhone, $mobilePhone);
                                          $count($allPhones) > 0 ? $allPhones : undefined
                                        )
                                    EOT
                },
                {
                  attribute          = "address"
                  jsonata_expression = <<-EOT
                                        (
                                          $mainAddress := $exists(address) ? [
                                            {
                                              "_tags": ["Primary Address"],
                                              "street": address.street,
                                              "postal_code": $exists(address.postalCode) ? $string(address.postalCode) : undefined,
                                              "city": address.city,
                                              "country": address.country
                                            }
                                          ] : [];
                                          
                                          $billingAddr := $exists(billingAddress) and billingAddress.street != '' ? [
                                            {
                                              "_tags": ["Billing Address"],
                                              "street": billingAddress.street,
                                              "postal_code": $exists(billingAddress.postalCode) ? $string(billingAddress.postalCode) : undefined,
                                              "city": billingAddress.city,
                                              "country": billingAddress.country
                                            }
                                          ] : [];
                                          
                                          $allAddresses := $append($mainAddress, $billingAddr);
                                          $count($allAddresses) > 0 ? $allAddresses : undefined
                                        )
                                    EOT
                },
                {
                  attribute          = "birthdate"
                  jsonata_expression = <<-EOT
                                        (
                                          $validDate := $exists(birthDate) ? $toMillis(birthDate) : undefined;
                                          $validDate ? birthDate : undefined
                                        )
                                    EOT
                },
              ]
              unique_ids = [
                "external_id",
              ]
            },
          ]
          meter_readings = []
        }
        enabled        = true
        name           = "FailingEvent"
        type           = "inbound"
      }
    },
  ]
}


terraform {
  required_providers {
    epilot-erp-integration = {
      source  = "epilot-dev/epilot-erp-integration"
      version = "0.15.0"
    }
  }
}

