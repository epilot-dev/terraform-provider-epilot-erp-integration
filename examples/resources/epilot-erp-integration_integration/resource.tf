resource "epilot-erp-integration_integration" "my_integration" {
  description = "Terraform creation integration"
  name        = "Terraform creation integration"
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