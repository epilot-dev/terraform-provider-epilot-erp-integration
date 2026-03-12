# epilot-erp-integration_integration.wemags:
resource "epilot-erp-integration_integration" "wemags" {
    access_token_ids   = []
    app_ids            = []
    description        = "Migrated from app_id: a1881da9-cdc3-49da-bbc6-af97fadbf108, component_id: 926ed2b5-cda7-4a28-92d2-4389bd5adfb7. Original config version: 2.0"
    environment_config = jsonencode(
        [
            {
                key      = "erp_wemag_d3.token_url"
                label    = "OAuth2 Token URL"
                order    = 0
                required = false
                type     = "String"
            },
            {
                description = "https://api.wemag.com/api/document-service/v2"
                key         = "erp_wemag_d3.base_url"
                label       = "Wemag Document Base URL"
                order       = 1
                required    = false
                type        = "String"
            },
            {
                description = "wng-edat"
                key         = "erp_wemag_d3.client_id"
                label       = "Wemag Document OAuth Client ID"
                order       = 2
                required    = false
                type        = "SecretString"
            },
            {
                key      = "erp_wemag_d3.client_secret"
                label    = "Wemag Document OAuth Client Secret"
                order    = 3
                required = false
                type     = "SecretString"
            },
        ]
    )
    name               = "Schleupen/Talend"
    use_cases          = jsonencode(
        [
            {
                configuration = {
                    event_catalog_event = "ServiceMeterReadingAdded"
                    mappings            = [
                        {
                            created_at         = "2026-03-12T14:01:41.882Z"
                            delivery           = {
                                type         = "webhook"
                                webhook_id   = "oyWhmnBPE7Nke2qnWsLFak"
                                webhook_name = "Service Meter Reading Added"
                            }
                            enabled            = true
                            jsonata_expression = <<-EOT
                                (
                                  $reading := meter_readings[0];
                                  $readingdate := $substring($reading.reading_timestamp, 0, 10);
                                  {
                                    "event_name": _event_name,
                                    "acknowledgeId": _ack_id,
                                    "meteringcode": meter.ma_lo_id ? meter.ma_lo_id : "",
                                    "devicenumber": meter.meter_number ? meter.meter_number : "",
                                    "counterid": meter_counters[0].obis_number ? meter_counters[0].obis_number : "",
                                    "value": $reading.value ? $reading.value : "",
                                    "readingdate": $readingdate ? $fromMillis(
                                      $toMillis($readingdate),
                                      "[Y0001]-[M01]-[D01]",
                                      "+0100"
                                    ) : "",
                                    "reason": "Portal Ablesung"
                                  }
                                )
                            EOT
                            name               = "Service Meter Reading Added"
                            updated_at         = "2026-03-12T14:01:41.882Z"
                        },
                    ]
                }
                enabled       = true
                name          = "Service Meter Reading Added"
                slug          = "service_meter_reading_added"
                type          = "outbound"
            },
            {
                configuration = {
                    event_catalog_event = "InstallmentUpdated"
                    mappings            = [
                        {
                            created_at         = "2026-03-12T13:37:09.282Z"
                            delivery           = {
                                type         = "webhook"
                                webhook_id   = "ksfeU4ke5cZRe5hhAj9QJq"
                                webhook_name = "Installment Rate Updated"
                            }
                            enabled            = true
                            id                 = "8198a9d2-abd0-43d7-bb08-4557db271569"
                            jsonata_expression = <<-EOT
                                (
                                  $ratedate := $substring(contract._updated_at, 0, 10);
                                  {
                                    "acknowledgeId": _ack_id,
                                    "contract_number": contract.contract_number ? contract.contract_number : "",
                                    "event_name": _event_name,
                                    "value": $string(contract.installment_amount ? contract.installment_amount : ""),
                                    "value_dec": contract.installment_amount_decimal ? contract.installment_amount_decimal : "",
                                    "ratedate": $ratedate and $ratedate != "unknown" ? $fromMillis(
                                      $toMillis($ratedate),
                                      "[Y0001]-[M01]-[D01]",
                                      "+0100"
                                    ) : ""
                                  }
                                )
                            EOT
                            name               = "Installment Rate Updated"
                            updated_at         = "2026-03-12T13:37:09.282Z"
                        },
                    ]
                }
                enabled       = true

                name          = "Change Installment Rate"
                slug          = "change_installment_rate"
                type          = "outbound"
            },
            {
                change_description = "Update malo to melo"
                configuration      = {
                    entities = [
                        {
                            entity_schema = "contact"
                            fields        = [
                                {
                                    attribute         = "customer_number"
                                    jsonataExpression = "$string(Rechnungseinheit.Vertragspartner.PersId)"
                                },
                                {
                                    attribute         = "complete_customer_number"
                                    jsonataExpression = "(\"0002\" & \"-\" & Rechnungseinheit.Vertragspartner.PIN & \"-\" & Rechnungseinheit.ReeId)"
                                },
                                {
                                    attribute         = "salutation"
                                    jsonataExpression = <<-EOT
                                        (
                                          $anrede := Rechnungseinheit.Vertragspartner.Anrede;
                                          $typ := Rechnungseinheit.Vertragspartner.Typ;
                                          $typ = 'N' ? (
                                            $anrede = 'Herr' ? 'Herr' : (
                                              $anrede = 'Frau' ? 'Frau' : undefined
                                            )
                                          ) : 'Firma/Ansprechpartner'
                                        )
                                    EOT
                                },
                                {
                                    attribute         = "title"
                                    jsonataExpression = "Rechnungseinheit.Vertragspartner.Titel != 'Unbekannt' ? Rechnungseinheit.Vertragspartner.Titel : undefined"
                                },
                                {
                                    attribute = "first_name"
                                    field     = "$.Rechnungseinheit.Vertragspartner.Vorname"
                                },
                                {
                                    attribute = "last_name"
                                    field     = "$.Rechnungseinheit.Vertragspartner.Name"
                                },
                                {
                                    attribute         = "address"
                                    jsonataExpression = <<-EOT
                                        (
                                          $abnahmestelle := Rechnungseinheit.Abnahmestelle;
                                          
                                          $deliveryAddress := $exists($abnahmestelle.Anschrift) ? [
                                            {
                                              "_tags": ["Lieferadresse"],
                                              "street": $abnahmestelle.Anschrift.Strasse,
                                              "street_number": $exists($abnahmestelle.Anschrift.Hnr) ? $string($abnahmestelle.Anschrift.Hnr) : undefined,
                                              "postal_code": $exists($abnahmestelle.Anschrift.PLZ) ? $string($abnahmestelle.Anschrift.PLZ) : undefined,
                                              "city": $abnahmestelle.Anschrift.Ort,
                                              "additional_info": $abnahmestelle.Anschrift.Ortsteil
                                            }
                                          ] : [];
                                          
                                          $deliveryAddress
                                        )
                                    EOT
                                },
                                {
                                    attribute         = "email"
                                    jsonataExpression = <<-EOT
                                        (
                                          $vertragspartner := Rechnungseinheit.Vertragspartner;
                                          $abwRechnungsempf := Rechnungseinheit.AbwRechnungsempf;
                                          
                                          $mainEmail := $exists($vertragspartner.mail) and $vertragspartner.mail != '' ? [
                                            {
                                              "_tags": ["Hauptadresse"],
                                              "email": $vertragspartner.mail
                                            }
                                          ] : [];
                                          
                                          $altEmail := $exists($abwRechnungsempf.mail) and $abwRechnungsempf.mail != '' and $abwRechnungsempf.mail != $vertragspartner.mail ? [
                                            {
                                              "_tags": ["Abweichender Rechnungsempfänger"],
                                              "email": $abwRechnungsempf.mail
                                            }
                                          ] : [];
                                          
                                          $allEmails := $append($mainEmail, $altEmail);
                                          $count($allEmails) > 0 ? $allEmails : undefined
                                        )
                                    EOT
                                },
                                {
                                    attribute         = "phone"
                                    jsonataExpression = <<-EOT
                                        (
                                          $vertragspartner := Rechnungseinheit.Vertragspartner;
                                          $abwRechnungsempf := Rechnungseinheit.AbwRechnungsempf;
                                          
                                          $mainPhone := $exists($vertragspartner.tel) and $vertragspartner.tel != '' ? [
                                            {
                                              "_tags": ["Hauptnummer"],
                                              "phone": $vertragspartner.tel
                                            }
                                          ] : [];
                                          
                                          $mainMobil := $exists($vertragspartner.mobil) and $vertragspartner.mobil != '' ? [
                                            {
                                              "_tags": ["Mobil"],
                                              "phone": $vertragspartner.mobil
                                            }
                                          ] : [];
                                          
                                          $altPhone := $exists($abwRechnungsempf.tel) and $abwRechnungsempf.tel != '' and $abwRechnungsempf.tel != $vertragspartner.tel ? [
                                            {
                                              "_tags": ["Abweichender Rechnungsempfänger"],
                                              "phone": $abwRechnungsempf.tel
                                            }
                                          ] : [];
                                          
                                          $altMobil := $exists($abwRechnungsempf.mobil) and $abwRechnungsempf.mobil != '' and $abwRechnungsempf.mobil != $vertragspartner.mobil ? [
                                            {
                                              "_tags": ["Abweichender Rechnungsempfänger", "Mobil"],
                                              "phone": $abwRechnungsempf.mobil
                                            }
                                          ] : [];
                                          
                                          $allPhones := $append($append($append($mainPhone, $mainMobil), $altPhone), $altMobil);
                                          $count($allPhones) > 0 ? $allPhones : undefined
                                        )
                                    EOT
                                },
                                {
                                    attribute         = "billing_account_number"
                                    jsonataExpression = "$string(Rechnungseinheit.ReeId)"
                                },
                                {
                                    attribute         = "contract_number"
                                    jsonataExpression = "$string(Rechnungseinheit.Vertrag.VtrNr)"
                                },
                                {
                                    attribute         = "customer_pin"
                                    jsonataExpression = "$exists(Rechnungseinheit.Vertragspartner.PIN) ? $string(Rechnungseinheit.Vertragspartner.PIN) : undefined"
                                },
                                {
                                    attribute         = "reenumber"
                                    comment           = "temporary"
                                    jsonataExpression = "$string(Rechnungseinheit.ReeId)"
                                },
                                {
                                    attribute         = "pinnumber"
                                    comment           = "temporary"
                                    jsonataExpression = "$exists(Rechnungseinheit.Vertragspartner.PIN) ? $string(Rechnungseinheit.Vertragspartner.PIN) : undefined"
                                },
                            ]
                            unique_ids    = [
                                "customer_number",
                            ]
                        },
                        {
                            entity_schema = "billing_account"
                            fields        = [
                                {
                                    attribute         = "billing_account_number"
                                    jsonataExpression = "$string(Rechnungseinheit.ReeId)"
                                },
                                {
                                    attribute = "billing_contact"
                                    relations = {
                                        items     = [
                                            {
                                                entity_schema = "contact"
                                                unique_ids    = [
                                                    {
                                                        attribute         = "customer_number"
                                                        jsonataExpression = "$string(Rechnungseinheit.Vertragspartner.PersId)"
                                                    },
                                                ]
                                            },
                                        ]
                                        operation = "_set"
                                    }
                                },
                                {
                                    attribute         = "billing_address"
                                    jsonataExpression = <<-EOT
                                        (
                                          $vertragspartner := Rechnungseinheit.Vertragspartner;
                                          $abwRechnungsempf := Rechnungseinheit.AbwRechnungsempf;
                                          
                                          $billingAddress := $exists($vertragspartner.Anschrift) ? [
                                            {
                                              "_tags": ["Rechnungsadresse"],
                                              "street": $vertragspartner.Anschrift.Strasse,
                                              "street_number": $exists($vertragspartner.Anschrift.Hnr) ? $string($vertragspartner.Anschrift.Hnr) : undefined,
                                              "postal_code": $exists($vertragspartner.Anschrift.PLZ) ? $string($vertragspartner.Anschrift.PLZ) : undefined,
                                              "city": $vertragspartner.Anschrift.Ort,
                                              "suburb": ($exists($vertragspartner.Anschrift.Ortsteil) and $vertragspartner.Anschrift.Ortsteil) ? $vertragspartner.Anschrift.Ortsteil : null
                                            }
                                          ] : [];
                                          
                                          $altBillingAddress := $exists($abwRechnungsempf.Anschrift) and $abwRechnungsempf.Anschrift.Strasse != '' ? [
                                            {
                                              "_tags": ["Abweichende Rechnungsadresse"],
                                              "street": $abwRechnungsempf.Anschrift.Strasse,
                                              "street_number": $exists($abwRechnungsempf.Anschrift.Hnr) ? $string($abwRechnungsempf.Anschrift.Hnr) : undefined,
                                              "postal_code": $exists($abwRechnungsempf.Anschrift.PLZ) ? $string($abwRechnungsempf.Anschrift.PLZ) : undefined,
                                              "city": $abwRechnungsempf.Anschrift.Ort,
                                              "suburb": ($exists($abwRechnungsempf.Anschrift.Ortsteil) and $abwRechnungsempf.Anschrift.Ortsteil) ? $abwRechnungsempf.Anschrift.Ortsteil : null
                                            }
                                          ] : [];
                                          
                                          $append($billingAddress, $altBillingAddress)
                                        )
                                    EOT
                                },
                                {
                                    attribute         = "payment_method"
                                    jsonataExpression = <<-EOT
                                        (
                                          $vertragspartner := Rechnungseinheit.Vertragspartner;
                                          $fullname := $vertragspartner.Typ = 'N' ? (
                                            $vertragspartner.Vorname & ' ' & $vertragspartner.Name
                                          ) : $vertragspartner.Name;
                                          
                                          [
                                            {
                                              "type": "payment_sepa",
                                              "data": {
                                                "iban": "",
                                                "bic_number": "",
                                                "bank_name": "",
                                                "fullname": $fullname,
                                                "start_date": "1900-01-01"
                                              }
                                            }
                                          ]
                                        )
                                    EOT
                                },
                            ]
                            unique_ids    = [
                                "billing_account_number",
                            ]
                        },
                        {
                            entity_schema = "contract"
                            fields        = [
                                {
                                    attribute = "status"
                                    constant  = "active"
                                },
                                {
                                    attribute         = "contract_number"
                                    jsonataExpression = "$string(Rechnungseinheit.Vertrag.VtrNr)"
                                },
                                {
                                    attribute         = "billing_account_number"
                                    jsonataExpression = "$string(Rechnungseinheit.ReeId)"
                                },
                                {
                                    attribute         = "contract_name"
                                    jsonataExpression = "Rechnungseinheit.Vertrag.Tarif & ' - ' & $string(Rechnungseinheit.Vertrag.VtrNr)"
                                },
                                {
                                    attribute = "verguetungsverzicht_vorhanden"
                                    field     = "$.Rechnungseinheit.Vertrag.VerguetungsverzichtVorhanden"
                                },
                                {
                                    attribute = "vertragstyp"
                                    field     = "$.Rechnungseinheit.Vertrag.VertragsTyp"
                                },
                                {
                                    attribute         = "kleinunternehmerregelung_hinterlegt"
                                    jsonataExpression = "((Rechnungseinheit.Vertrag.VertragsTyp = 'SLP' and Rechnungseinheit.Vertrag.Steuernummer = '') ? 'Ja' : 'Nein')"
                                },
                                {
                                    attribute         = "start_date"
                                    jsonataExpression = <<-EOT
                                        (
                                          $date := Rechnungseinheit.Vertrag.Beginn;
                                          $exists($date) and $date != '' ? $date : undefined
                                        )
                                    EOT
                                },
                                {
                                    attribute         = "move_in_date"
                                    jsonataExpression = <<-EOT
                                        (
                                          $date := Rechnungseinheit.Vertrag.Beginn;
                                          $exists($date) and $date != '' ? $date : undefined
                                        )
                                    EOT
                                },
                                {
                                    attribute         = "branch"
                                    jsonataExpression = <<-EOT
                                        (
                                          $gb := Rechnungseinheit.Vertrag.GB;
                                          $gb = 'SUE' ? 'power' : (
                                            $gb = 'GAS' ? 'gas' : (
                                              $gb = 'WAE' ? 'heat' : undefined
                                            )
                                          )
                                        )
                                    EOT
                                },
                                {
                                    attribute         = "installment_amount_decimal"
                                    jsonataExpression = "$exists(Rechnungseinheit.Vertrag.Abschlag) ? $formatNumber($abs($number(Rechnungseinheit.Vertrag.Abschlag)), '#0.00') : '0.00'"
                                },
                                {
                                    attribute         = "installment_amount"
                                    jsonataExpression = "$exists(Rechnungseinheit.Vertrag.Abschlag) ? $string($round($abs($number(Rechnungseinheit.Vertrag.Abschlag)) * 100)) : '0'"
                                },
                                {
                                    attribute         = "installment_amount_currency"
                                    jsonataExpression = "'EUR'"
                                },
                                {
                                    attribute         = "delivery_address"
                                    jsonataExpression = <<-EOT
                                        (
                                          $abnahmestelle := Rechnungseinheit.Abnahmestelle;
                                          $exists($abnahmestelle.Anschrift) ? [
                                            {
                                              "street": $abnahmestelle.Anschrift.Strasse,
                                              "street_number": $exists($abnahmestelle.Anschrift.Hnr) ? $string($abnahmestelle.Anschrift.Hnr) : undefined,
                                              "postal_code": $exists($abnahmestelle.Anschrift.PLZ) ? $string($abnahmestelle.Anschrift.PLZ) : undefined,
                                              "city": $abnahmestelle.Anschrift.Ort,
                                              "suburb": ($exists($vertragspartner.Anschrift.Ortsteil) and $vertragspartner.Anschrift.Ortsteil) ? $vertragspartner.Anschrift.Ortsteil : null,
                                              "country": "DE"
                                            }
                                          ] : undefined
                                        )
                                    EOT
                                },
                                {
                                    attribute         = "schleupen_marktlokation"
                                    jsonataExpression = "$exists(Rechnungseinheit.Vertrag.Marktlokation) ? $string(Rechnungseinheit.Vertrag.Marktlokation) : undefined"
                                },
                                {
                                    attribute         = "schleupen_tarif"
                                    jsonataExpression = "Rechnungseinheit.Vertrag.Tarif"
                                },
                                {
                                    attribute         = "schleupen_leistung"
                                    jsonataExpression = "Rechnungseinheit.Vertrag.Leistung"
                                },
                                {
                                    attribute         = "schleupen_aktennummer"
                                    jsonataExpression = "$exists(Rechnungseinheit.Vertrag.Aktennummer) ? $string(Rechnungseinheit.Vertrag.Aktennummer) : undefined"
                                },
                                {
                                    attribute         = "schleupen_steuernummer"
                                    jsonataExpression = "Rechnungseinheit.Vertrag.Steuernummer"
                                },
                                {
                                    attribute         = "billing_due_day"
                                    jsonataExpression = "$number($split(Rechnungseinheit.Vertrag.Faelligkeit, \"-\")[2])"
                                },
                                {
                                    attribute = "anz_abschlag"
                                    field     = "$.Rechnungseinheit.ANZ_ABSCHLAG"
                                },
                                {
                                    attribute = "anz_znrhist"
                                    field     = "$.Rechnungseinheit.ANZ_ZNRHIST"
                                },
                                {
                                    attribute = "anz_kur"
                                    field     = "$.Rechnungseinheit.ANZ_KUR"
                                },
                                {
                                    attribute = "customer"
                                    relations = {
                                        items     = [
                                            {
                                                entity_schema = "contact"
                                                unique_ids    = [
                                                    {
                                                        attribute         = "customer_number"
                                                        jsonataExpression = "$string(Rechnungseinheit.Vertragspartner.PersId)"
                                                    },
                                                ]
                                            },
                                        ]
                                        operation = "_set"
                                    }
                                },
                                {
                                    attribute = "billing_account"
                                    relations = {
                                        items     = [
                                            {
                                                entity_schema = "billing_account"
                                                unique_ids    = [
                                                    {
                                                        attribute         = "billing_account_number"
                                                        jsonataExpression = "$string(Rechnungseinheit.ReeId)"
                                                    },
                                                ]
                                            },
                                        ]
                                        operation = "_set"
                                    }
                                },
                                {
                                    attribute     = "billing_address"
                                    relation_refs = {
                                        items     = [
                                            {
                                                entity_schema = "billing_account"
                                                path          = "billing_address"
                                                unique_ids    = [
                                                    {
                                                        attribute         = "billing_account_number"
                                                        jsonataExpression = "$string(Rechnungseinheit.ReeId)"
                                                    },
                                                ]
                                                value         = {
                                                    attribute         = "billing_address"
                                                    jsonataExpression = <<-EOT
                                                        (
                                                          $vertragspartner := Rechnungseinheit.Vertragspartner;
                                                          $abwRechnungsempf := Rechnungseinheit.AbwRechnungsempf;
                                                          
                                                          $billingAddress := $exists($vertragspartner.Anschrift) ? [
                                                            {
                                                              "_tags": ["Rechnungsadresse"],
                                                              "street": $vertragspartner.Anschrift.Strasse,
                                                              "street_number": $exists($vertragspartner.Anschrift.Hnr) ? $string($vertragspartner.Anschrift.Hnr) : undefined,
                                                              "postal_code": $exists($vertragspartner.Anschrift.PLZ) ? $string($vertragspartner.Anschrift.PLZ) : undefined,
                                                              "city": $vertragspartner.Anschrift.Ort,
                                                              "suburb": ($exists($vertragspartner.Anschrift.Ortsteil) and $vertragspartner.Anschrift.Ortsteil) ? $vertragspartner.Anschrift.Ortsteil : null
                                                            }
                                                          ] : [];
                                                          
                                                          $altBillingAddress := $exists($abwRechnungsempf.Anschrift) and $abwRechnungsempf.Anschrift.Strasse != '' ? [
                                                            {
                                                              "_tags": ["Abweichende Rechnungsadresse"],
                                                              "street": $abwRechnungsempf.Anschrift.Strasse,
                                                              "street_number": $exists($abwRechnungsempf.Anschrift.Hnr) ? $string($abwRechnungsempf.Anschrift.Hnr) : undefined,
                                                              "postal_code": $exists($abwRechnungsempf.Anschrift.PLZ) ? $string($abwRechnungsempf.Anschrift.PLZ) : undefined,
                                                              "city": $abwRechnungsempf.Anschrift.Ort,
                                                              "suburb": ($exists($abwRechnungsempf.Anschrift.Ortsteil) and $abwRechnungsempf.Anschrift.Ortsteil) ? $abwRechnungsempf.Anschrift.Ortsteil : null
                                                            }
                                                          ] : [];
                                                          
                                                          $append($billingAddress, $altBillingAddress)
                                                        )
                                                    EOT
                                                    operation         = "_append"
                                                }
                                            },
                                        ]
                                        operation = "_set"
                                    }
                                },
                            ]
                            unique_ids    = [
                                "contract_number",
                            ]
                        },
                        {
                            entity_schema     = "meter"
                            fields            = [
                                {
                                    attribute         = "meter_number"
                                    jsonataExpression = "$string(ZNR)"
                                },
                                {
                                    attribute         = "me_lo_id"
                                    jsonataExpression = "$exists(ZPB) ? $string(ZPB) : undefined"
                                },
                                {
                                    attribute = "sector"
                                    constant  = "power"
                                },
                                {
                                    attribute = "status"
                                    constant  = "active"
                                },
                                {
                                    attribute         = "address"
                                    jsonataExpression = <<-EOT
                                        (
                                          $abnahmestelle := Rechnungseinheit.Abnahmestelle;
                                          $exists($abnahmestelle.Anschrift) ? [
                                            {
                                              "street": $abnahmestelle.Anschrift.Strasse,
                                              "street_number": $exists($abnahmestelle.Anschrift.Hnr) ? $string($abnahmestelle.Anschrift.Hnr) : undefined,
                                              "postal_code": $exists($abnahmestelle.Anschrift.PLZ) ? $string($abnahmestelle.Anschrift.PLZ) : undefined,
                                              "city": $abnahmestelle.Anschrift.Ort,
                                              "additional_info": $abnahmestelle.Anschrift.Ortsteil,
                                              "country": "DE"
                                            }
                                          ] : undefined
                                        )
                                    EOT
                                },
                                {
                                    attribute = "contract"
                                    relations = {
                                        items     = [
                                            {
                                                entity_schema = "contract"
                                                unique_ids    = [
                                                    {
                                                        attribute         = "contract_number"
                                                        jsonataExpression = "$string(Rechnungseinheit.Vertrag.VtrNr)"
                                                    },
                                                ]
                                            },
                                        ]
                                        operation = "_set"
                                    }
                                },
                                {
                                    attribute = "customer"
                                    relations = {
                                        items     = [
                                            {
                                                entity_schema = "contact"
                                                unique_ids    = [
                                                    {
                                                        attribute         = "customer_number"
                                                        jsonataExpression = "$string(Rechnungseinheit.Vertragspartner.PersId)"
                                                    },
                                                ]
                                            },
                                        ]
                                        operation = "_set"
                                    }
                                },
                                {
                                    attribute = "external_id"
                                    field     = "ZWID"
                                },
                                {
                                    attribute = "counters"
                                    relations = {
                                        items     = [
                                            {
                                                entity_schema = "meter_counter"
                                                unique_ids    = [
                                                    {
                                                        attribute         = "obis_number"
                                                        jsonataExpression = "$string(ZWID)"
                                                    },
                                                ]
                                            },
                                        ]
                                        operation = "_set"
                                    }
                                },
                            ]
                            jsonataExpression = <<-EOT
                                (
                                  $mengenpunkte := Rechnungseinheit.Abnahmestelle.Mengenpunkt;
                                  $rechnungseinheit := Rechnungseinheit;
                                  $exists($mengenpunkte) and $count($mengenpunkte) > 0 ? $mengenpunkte.{
                                    "ZNR": ZNR,
                                    "ZPB": ZPB,
                                    "ZWID": ZWID,
                                    "Rechnungseinheit": $rechnungseinheit
                                  } : []
                                )
                            EOT
                            unique_ids        = [
                                "external_id",
                            ]
                        },
                        {
                            entity_schema     = "meter_counter"
                            fields            = [
                                {
                                    attribute         = "obis_number"
                                    jsonataExpression = "$string(ZWID)"
                                },
                                {
                                    attribute = "tariff_type"
                                    constant  = "et"
                                },
                                {
                                    attribute = "external_id"
                                    field     = "ZWID"
                                },
                                {
                                    attribute = "unit"
                                    constant  = "kWh"
                                },
                            ]
                            jsonataExpression = <<-EOT
                                (
                                  $mengenpunkte := Rechnungseinheit.Abnahmestelle.Mengenpunkt;
                                  $exists($mengenpunkte) and $count($mengenpunkte) > 0 ? $mengenpunkte.{
                                    "ZNR": ZNR,
                                    "ZPB": ZPB,
                                    "ZWID": ZWID
                                  } : []
                                )
                            EOT
                            unique_ids        = [
                                "external_id",
                            ]
                        },
                        {
                            enabled       = <<-EOT
                                (
                                  $isUUID := function($v) {
                                    $type($v) = "string" and
                                    $v ~> /^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$/
                                  };
                                  
                                  $isUUID(Rechnungseinheit.portal_user_id)
                                )
                            EOT
                            entity_schema = "portal_user"
                            fields        = [
                                {
                                    attribute = "_id"
                                    field     = "$.Rechnungseinheit.portal_user_id"
                                },
                                {
                                    attribute = "represents"
                                    relations = {
                                        items     = [
                                            {
                                                entity_schema = "contact"
                                                unique_ids    = [
                                                    {
                                                        attribute         = "customer_number"
                                                        jsonataExpression = "$string(Rechnungseinheit.Vertragspartner.PersId)"
                                                    },
                                                ]
                                            },
                                        ]
                                        operation = "_append"
                                    }
                                },
                            ]
                            unique_ids    = [
                                "_id",
                            ]
                        },
                    ]
                }
                enabled            = true
                name               = "Rechnungseinheit"
                type               = "inbound"
            },
            {
                change_description = "Add strict date-based meter reading matching to avoid duplicates"
                configuration      = {
                    meter_readings = [
                        {
                            fields            = [
                                {
                                    attribute = "external_id"
                                    field     = "abldatum"
                                },
                                {
                                    attribute         = "timestamp"
                                    jsonataExpression = "$fromMillis($toMillis(abldatum, \"[D01]-[M01]-[Y0001]\"))"
                                },
                                {
                                    attribute = "value"
                                    field     = "stand"
                                },
                                {
                                    attribute = "direction"
                                    constant  = "feed-out"
                                },
                                {
                                    attribute         = "reason"
                                    jsonataExpression = <<-EOT
                                        (
                                          $grund := ablgrund;
                                          $grund = 'Einbau' ? 'first' : (
                                            $grund = 'Ausbau' ? 'last' : (
                                              $grund = 'Wechsel' or $grund = 'Zählerwechsel' or $grund = 'Zahlerwechsel' ? 'meter_change' : (
                                                $grund = 'Vertragsänderung' or $grund = 'Lieferantenwechsel' ? 'contract_change' : (
                                                  $grund = 'Zwischenablesung' or $grund = 'Sonderablesung' ? 'irregular' : 'regular'
                                                )
                                              )
                                            )
                                          )
                                        )
                                    EOT
                                },
                                {
                                    attribute         = "source"
                                    jsonataExpression = <<-EOT
                                        (
                                          $kennz := ablkennz;
                                          $kennz = 'Portal Ablesung' or $kennz = 'Selbstablesung' ? 'ECP' : 'ERP'
                                        )
                                    EOT
                                },
                            ]
                            jsonataExpression = "$.Zaehlerstaende.Zaehlerstand"
                            meter             = {
                                unique_ids = [
                                    {
                                        attribute = "external_id"
                                        field     = "zwid"
                                    },
                                ]
                            }
                            meter_counter     = {
                                unique_ids = [
                                    {
                                        attribute = "external_id"
                                        field     = "zwid"
                                    },
                                ]
                            }
                            reading_matching  = "strict-date"
                        },
                    ]
                }
                enabled            = true
                name               = "Zaehlerstaende"
                type               = "inbound"
            },
            {
                configuration = {
                    auth         = {
                        client_id     = "\\{{env.erp_wemag_d3.client_id}}"
                        client_secret = "\\{{env.erp_wemag_d3.client_secret}}"
                        scope         = "openid"
                        token_url     = "\\{{env.erp_wemag_d3.token_url}}"
                        type          = "oauth2_client_credentials"
                    }
                    params       = [
                        {
                            description = "d.3 mandant / tenant (e.g. WEMAG, WNG)"
                            name        = "mandant"
                            required    = true
                        },
                        {
                            description = "d.3 document ID (e.g. PT00188186)"
                            name        = "documentId"
                            required    = true
                        },
                    ]
                    requires_vpc = true
                    response     = {
                        body         = "steps[0].body.data"
                        content_type = "'application/' & steps[0].body.docInfo.docExt"
                        encoding     = "base64"
                        filename     = "steps[0].body.docInfo.originalFileName"
                    }
                    steps        = [
                        {
                            method        = "GET"
                            response_type = "json"
                            url           = "\\{{env.erp_wemag_d3.base_url}}/document/mandant/{{params.mandant}}/doc/{{params.documentId}}/download"
                        },
                    ]
                }
                enabled       = true
                name          = "WEMAG d.3 Document Download"
                type          = "file_proxy"
            },
            {
                change_description = "Add art_des_dokuments"
                configuration      = {
                    entities = [
                        {
                            entity_schema     = "file"
                            fields            = [
                                {
                                    attribute = "external_id"
                                    field     = "documentid"
                                },
                                {
                                    attribute = "filename"
                                    field     = "filename_new"
                                },
                                {
                                    attribute = "alt_text"
                                    field     = "filetype"
                                },
                                {
                                    attribute = "type_description"
                                    field     = "filetype"
                                },
                                {
                                    attribute         = "mime_type"
                                    jsonataExpression = <<-EOT
                                        (
                                          $parts := $split(filename_original, ".");
                                          $ext := $lowercase($parts[$count($parts) - 1]);
                                          $ext = "pdf" ? "application/pdf" :
                                          $ext = "png" ? "image/png" :
                                          $ext = "jpg" or $ext = "jpeg" ? "image/jpeg" :
                                          $ext = "gif" ? "image/gif" :
                                          $ext = "webp" ? "image/webp" :
                                          $ext = "svg" ? "image/svg+xml" :
                                          $ext = "txt" ? "text/plain" :
                                          $ext = "csv" ? "text/csv" :
                                          $ext = "json" ? "application/json" :
                                          $ext = "xml" ? "application/xml" :
                                          $ext = "html" or $ext = "htm" ? "text/html" :
                                          $ext = "zip" ? "application/zip" :
                                          $ext = "doc" ? "application/msword" :
                                          $ext = "docx" ? "application/vnd.openxmlformats-officedocument.wordprocessingml.document" :
                                          $ext = "xls" ? "application/vnd.ms-excel" :
                                          $ext = "xlsx" ? "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" :
                                          $ext = "ppt" ? "application/vnd.ms-powerpoint" :
                                          $ext = "pptx" ? "application/vnd.openxmlformats-officedocument.presentationml.presentation" :
                                          "application/octet-stream"
                                        )
                                    EOT
                                },
                                {
                                    attribute = "file_date"
                                    field     = "created"
                                },
                                {
                                    attribute = "language"
                                    constant  = "de"
                                },
                                {
                                    attribute = "shared_with_end_customer"
                                    constant  = true
                                },
                                {
                                    attribute         = "is_invoice"
                                    jsonataExpression = "filetype = 'Turnusabrechnung'"
                                },
                                {
                                    attribute         = "art_des_dokuments"
                                    jsonataExpression = "filetype = 'Turnusabrechnung' ? \"Rechnung\" : \"Andere\""
                                },
                                {
                                    attribute         = "readable_size"
                                    jsonataExpression = <<-EOT
                                        (
                                          $b := filesize_byte;
                                          $units := ["B","KB","MB","GB","TB"];
                                          $i := $floor($min([$count($units)-1, $floor($log($b)/$log(1024))]));
                                          $value := $round($b / $power(1024, $i), 2);
                                          $string($value) & " " & $units[$i]
                                        )
                                    EOT
                                },
                                {
                                    attribute = "size_bytes"
                                    field     = "filesize_byte"
                                },
                                {
                                    attribute = "type"
                                    constant  = "document"
                                },
                                {
                                    attribute      = "custom_download_url"
                                    file_proxy_url = {
                                        params      = {
                                            documentId = {
                                                field = "documentid"
                                            }
                                            mandant    = {
                                                constant = "WNG"
                                            }
                                        }
                                        use_case_id = "6e1ece3b-0011-4f99-9e4e-9b9756324188"
                                    }
                                },
                                {
                                    attribute = "portal_access"
                                    constant  = [
                                        "e8522926-3b95-43a4-9386-cdd7dfe1faff",
                                    ]
                                },
                            ]
                            jsonataExpression = "documents"
                            unique_ids        = [
                                "external_id",
                            ]
                        },
                        {
                            entity_schema = "contact"
                            fields        = [
                                {
                                    attribute         = "customer_pin"
                                    jsonataExpression = "$string(documents[0].pin)"
                                },
                                {
                                    attribute = "documents"
                                    relations = {
                                        jsonataExpression = "[documents.{\"entity_schema\": \"file\", \"unique_ids\": [{\"attribute\": \"external_id\", \"constant\": documentid}]}]"
                                        operation         = "_append"
                                    }
                                },
                            ]
                            unique_ids    = [
                                "customer_pin",
                            ]
                        },
                        {
                            entity_schema = "billing_account"
                            fields        = [
                                {
                                    attribute         = "billing_account_number"
                                    jsonataExpression = "$string(documents[0].ree)"
                                },
                                {
                                    attribute = "documents"
                                    relations = {
                                        jsonataExpression = "[documents.{\"entity_schema\": \"file\", \"unique_ids\": [{\"attribute\": \"external_id\", \"constant\": documentid}]}]"
                                        operation         = "_append"
                                    }
                                },
                            ]
                            unique_ids    = [
                                "billing_account_number",
                            ]
                        },
                    ]
                }
                enabled            = true
                name               = "DocumentChange"
                type               = "inbound"
            },
            {
                change_description = "Configuration updated"
                configuration      = {
                    event_catalog_event = "BillingAddressUpdated"
                    mappings            = [
                        {
                            created_at         = "2026-03-12T13:11:37.551Z"
                            delivery           = {
                                type         = "webhook"
                                webhook_id   = "tT4m2S1rnRoC7ashf96p7o"
                                webhook_name = "Billing Address Updated"
                            }
                            enabled            = true
                            id                 = "39ac6bdc-cdc4-4b00-b9ed-93f04df9f6dd"
                            jsonata_expression = <<-EOT
                                (
                                  $changedate := $substring(billing_account._updated_at, 0, 10);
                                  {
                                    "acknowledgeId": _ack_id ? _ack_id : "",
                                    "pinnumber": customer.customer_pin ? customer.customer_pin : "",
                                    "reenumber": billing_account.billing_account_number ? billing_account.billing_account_number : "",
                                    "postalcode": billing_account.billing_address[0].postal_code ? billing_account.billing_address[0].postal_code : "",
                                    "city": billing_account.billing_address[0].city ? billing_account.billing_address[0].city : "",
                                    "citydistrict": billing_account.billing_address[0].suburb ? billing_account.billing_address[0].suburb : "",
                                    "street": billing_account.billing_address[0].street ? billing_account.billing_address[0].street : "",
                                    "housenumber": billing_account.billing_address[0].street_number ? billing_account.billing_address[0].street_number : "",
                                    "event_name": _event_name,
                                    "additional_info": billing_account.billing_address[0].additional_info ? billing_account.billing_address[0].additional_info : "",
                                    "changedate": $changedate ? $fromMillis(
                                      $toMillis($changedate),
                                      "[Y0001]-[M01]-[D01]",
                                      "+0100"
                                    ) : ""
                                  }
                                )
                            EOT
                            name               = "Billing Address Updated"
                            updated_at         = "2026-03-12T13:17:31.828Z"
                        },
                    ]
                }
                enabled            = true
                name               = "Billing Address Updated"
                slug               = "billing_address_updated"
                type               = "outbound"
            },
            {
                change_description = "Configuration updated"
                configuration      = {
                    event_catalog_event = "PaymentMethodUpdated"
                    mappings            = [
                        {
                            created_at         = "2026-03-12T13:04:28.752Z"
                            delivery           = {
                                type         = "webhook"
                                webhook_id   = "h4qByJzswRCyRBwnEvhuL2"
                                webhook_name = "Payment Method Update"
                            }
                            enabled            = true
                            id                 = "559cc776-f999-457d-b2ea-4beb1092d919"
                            jsonata_expression = <<-EOT
                                {
                                  "acknowledgeId": _ack_id,
                                  "event_name": _event_name,
                                  "pinnumber": customer.customer_pin,
                                  "reenumber": billing_account.billing_account_number,
                                  "iban": billing_account.payment_method[0].data.iban,
                                  "bic": billing_account.payment_method[0].data.bic_number,
                                  "accountHolder": billing_account.payment_method[0].data.fullname,
                                  "accounttype": billing_account.sepamandat_erteilt ? "FG" : "GH",
                                  "sepamandate_from": $substring(billing_account._updated_at, 0, 10),
                                  "sepamandate_to": "",
                                  "account_valid_from": $substring(billing_account._updated_at, 0, 10),
                                  "account_valid_to": ""
                                }
                            EOT
                            name               = "Payment Method Update"
                            updated_at         = "2026-03-12T13:24:11.965Z"
                        },
                    ]
                }
                enabled            = true
                name               = "Payment Method Change"
                slug               = "payment_method_change"
                type               = "outbound"
            },
            {
                change_description = "Configuration updated"
                configuration      = {
                    event_catalog_event = "MeterReadingAdded"
                    mappings            = [
                        {
                            created_at         = "2026-03-12T13:43:11.259Z"
                            delivery           = {
                                type         = "webhook"
                                webhook_id   = "qaFBi9s2A3Ch1RhoZSFqVd"
                                webhook_name = "Meter Reading Added"
                            }
                            enabled            = true
                            id                 = "e75b1925-1e55-4906-9ff6-74d574ffbf6a"
                            jsonata_expression = <<-EOT
                                (
                                  $reading := meter_readings[0];
                                  $readingdate := $substring($reading.reading_timestamp, 0, 10);
                                  {
                                    "meteringcode": meter.ma_lo_id ? meter.ma_lo_id : "",
                                    "event_name": _event_name,
                                    "acknowledgeId": _ack_id,
                                    "devicenumber": meter.meter_number ? meter.meter_number : "",
                                    "counterid": $reading.obis_number ? $reading.obis_number : "",
                                    "value": $reading.value ? $reading.value : "",
                                    "readingdate": $readingdate ? $fromMillis(
                                      $toMillis($readingdate),
                                      "[Y0001]-[M01]-[D01]",
                                      "+0100"
                                    ) : "",
                                    "reason": "Portal Ablesung"
                                  }
                                )
                            EOT
                            name               = "Meter Reading Added"
                            updated_at         = "2026-03-12T13:44:18.738Z"
                        },
                    ]
                }
                enabled            = false
                name               = "Meter Reading Added"
                slug               = "meter_reading_added"
                type               = "outbound"
            },
            {
                change_description = "Add mapping for art_des_dokuments"
                configuration      = {
                    entities = [
                        {
                            entity_schema     = "file"
                            fields            = [
                                {
                                    attribute = "external_id"
                                    field     = "documentid"
                                },
                                {
                                    attribute = "filename"
                                    field     = "filename_new"
                                },
                                {
                                    attribute = "alt_text"
                                    field     = "filetype"
                                },
                                {
                                    attribute = "type_description"
                                    field     = "filetype"
                                },
                                {
                                    attribute         = "mime_type"
                                    jsonataExpression = <<-EOT
                                        (
                                          $parts := $split(filename_original, ".");
                                          $ext := $lowercase($parts[$count($parts) - 1]);
                                          $ext = "pdf" ? "application/pdf" :
                                          $ext = "png" ? "image/png" :
                                          $ext = "jpg" or $ext = "jpeg" ? "image/jpeg" :
                                          $ext = "gif" ? "image/gif" :
                                          $ext = "webp" ? "image/webp" :
                                          $ext = "svg" ? "image/svg+xml" :
                                          $ext = "txt" ? "text/plain" :
                                          $ext = "csv" ? "text/csv" :
                                          $ext = "json" ? "application/json" :
                                          $ext = "xml" ? "application/xml" :
                                          $ext = "html" or $ext = "htm" ? "text/html" :
                                          $ext = "zip" ? "application/zip" :
                                          $ext = "doc" ? "application/msword" :
                                          $ext = "docx" ? "application/vnd.openxmlformats-officedocument.wordprocessingml.document" :
                                          $ext = "xls" ? "application/vnd.ms-excel" :
                                          $ext = "xlsx" ? "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" :
                                          $ext = "ppt" ? "application/vnd.ms-powerpoint" :
                                          $ext = "pptx" ? "application/vnd.openxmlformats-officedocument.presentationml.presentation" :
                                          "application/octet-stream"
                                        )
                                    EOT
                                },
                                {
                                    attribute = "file_date"
                                    field     = "created"
                                },
                                {
                                    attribute = "language"
                                    constant  = "de"
                                },
                                {
                                    attribute = "shared_with_end_customer"
                                    constant  = true
                                },
                                {
                                    attribute         = "is_invoice"
                                    jsonataExpression = "filetype = 'Turnusabrechnung'"
                                },
                                {
                                    attribute         = "art_des_dokuments"
                                    jsonataExpression = "filetype = 'Turnusabrechnung' ? \"Rechnung\" : \"Andere\""
                                },
                                {
                                    attribute         = "readable_size"
                                    jsonataExpression = <<-EOT
                                        (
                                          $b := filesize_byte;
                                          $b < 1024 ? $string($b) & " B" :
                                          $b < 1048576 ? $string($round($b/1024, 2)) & " KB" :
                                          $b < 1073741824 ? $string($round($b/1048576, 2)) & " MB" :
                                          $b < 1099511627776 ? $string($round($b/1073741824, 2)) & " GB" :
                                          $string($round($b/1099511627776, 2)) & " TB"
                                        )
                                    EOT
                                },
                                {
                                    attribute = "size_bytes"
                                    field     = "filesize_byte"
                                },
                                {
                                    attribute = "type"
                                    constant  = "document"
                                },
                                {
                                    attribute      = "custom_download_url"
                                    file_proxy_url = {
                                        params      = {
                                            documentId = {
                                                field = "documentid"
                                            }
                                            mandant    = {
                                                constant = "WNG"
                                            }
                                        }
                                        use_case_id = "6e1ece3b-0011-4f99-9e4e-9b9756324188"
                                    }
                                },
                            ]
                            jsonataExpression = "Dokumente.Dokument"
                            unique_ids        = [
                                "external_id",
                            ]
                        },
                        {
                            entity_schema = "contact"
                            fields        = [
                                {
                                    attribute         = "customer_pin"
                                    jsonataExpression = "$string(Dokumente.Dokument[0].pin)"
                                },
                                {
                                    attribute = "documents"
                                    relations = {
                                        jsonataExpression = "[Dokumente.Dokument.{\"entity_schema\": \"file\", \"unique_ids\": [{\"attribute\": \"external_id\", \"constant\": documentid}]}]"
                                        operation         = "_append"
                                    }
                                },
                            ]
                            unique_ids    = [
                                "customer_pin",
                            ]
                        },
                        {
                            entity_schema = "billing_account"
                            fields        = [
                                {
                                    attribute         = "billing_account_number"
                                    jsonataExpression = "$string(Dokumente.Dokument[0].ree)"
                                },
                                {
                                    attribute = "documents"
                                    relations = {
                                        jsonataExpression = "[Dokumente.Dokument.{\"entity_schema\": \"file\", \"unique_ids\": [{\"attribute\": \"external_id\", \"constant\": documentid}]}]"
                                        operation         = "_append"
                                    }
                                },
                            ]
                            unique_ids    = [
                                "billing_account_number",
                            ]
                        },
                        {
                            entity_schema = "contract"
                            fields        = [
                                {
                                    attribute         = "billing_account_number"
                                    jsonataExpression = "$string(Dokumente.Dokument[0].ree)"
                                },
                                {
                                    attribute = "documents"
                                    relations = {
                                        jsonataExpression = "[Dokumente.Dokument.{\"entity_schema\": \"file\", \"unique_ids\": [{\"attribute\": \"external_id\", \"constant\": documentid}]}]"
                                        operation         = "_append"
                                    }
                                },
                            ]
                            unique_ids    = [
                                "billing_account_number",
                            ]
                        },
                    ]
                }
                enabled            = true
                name               = "D3Metadaten"
                type               = "inbound"
            },
            {
                configuration = {
                    entities = [
                        {
                            entity_schema     = "billing_account"
                            fields            = [
                                {
                                    attribute         = "billing_account_number"
                                    jsonataExpression = "$string(Ree)"
                                },
                                {
                                    attribute         = "payment_method"
                                    jsonataExpression = <<-EOT
                                        [
                                          $.Konto.{
                                              "type": "payment_sepa",
                                              "data": {
                                                "iban": IBAN,
                                                "bic_number": BIC,
                                                "bank_name": Bankname,
                                                "fullname": Inhaber,
                                                "start_date": $exists(Sepa_gueltig_ab) ? Sepa_gueltig_ab : "1900-01-01"
                                              }
                                          }
                                        ]
                                    EOT
                                },
                            ]
                            jsonataExpression = <<-EOT
                                (
                                  $data := Kontoverbindungen.Konto;
                                  $distinctRee := $distinct($data.Ree);
                                  $distinctRee.(
                                    $r := $;
                                    {
                                      "Ree": $number($r),
                                      "Konto": $data[Ree = $r]
                                    }
                                  )
                                )
                            EOT
                            unique_ids        = [
                                "billing_account_number",
                            ]
                        },
                    ]
                }
                enabled       = true
                name          = "Kontoverbindungen"
                type          = "inbound"
            },
        ]
    )
}
