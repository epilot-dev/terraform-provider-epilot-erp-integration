# resource "epilot-erp-integration_integration" "my_integration" {
#   description = "Terraform creation integration"
#   name        = "Terraform creation integration"
# }


import {
  to = epilot-erp-integration_integration.my_integrationsssss
  id = "08491890-bbe1-4372-89dc-e92f15de0290"
}

terraform {
  required_providers {
    epilot-erp-integration = {
      source  = "epilot-dev/epilot-erp-integration"
      version = "0.10.4"
    }
  }
}

provider "epilot-erp-integration" {
  # Configuration options
  epilot_auth = ""
}