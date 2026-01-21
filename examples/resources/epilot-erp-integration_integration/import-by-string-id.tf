# import {
#   to = epilot-erp-integration_integration.my_epilot-erp-integration_integration
#   id = "9ff6abda-e954-4091-aecb-a74680824f4c"
# }


terraform {
  required_providers {
    epilot-erp-integration = {
      source  = "epilot-dev/epilot-erp-integration"
      version = "0.12.0"
    }
  }
}

provider "epilot-erp-integration" {
  epilot_auth = ""
}