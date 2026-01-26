# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
# resource "epilot-erp-integration_integration" "mine" {
#   description = "tada"
#   name        = "Tadaaaaaa integration"
#   use_cases = [
#     {
#       outbound = {
#         change_description = "tada"
#         configuration = {
#           key = jsonencode("value")
#         }
#         enabled = true
#         name    = "Tadaaaaaa integration"
#         type    = "outbound"
#       }
#     }
#   ]
# }


resource "epilot-erp-integration_integration" "mine" {
}


terraform {
  required_providers {
    epilot-erp-integration = {
      source  = "epilot-dev/epilot-erp-integration"
      version = "0.13.0"
    }
  }
}

provider "epilot-erp-integration" {
  
}