terraform {
  required_providers {
    epilot-erp-integration = {
      source  = "epilot-dev/epilot-erp-integration"
      version = "0.21.7"
    }
  }
}

provider "epilot-erp-integration" {
  epilot_auth = "<YOUR_EPILOT_AUTH>" # Required
  server_url  = "..."                # Optional
}