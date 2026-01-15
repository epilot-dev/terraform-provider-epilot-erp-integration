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
  epilot_auth = "eyJraWQiOiJ2ZFR0MGQrK1RMc2FQZ2tsQ3AzMDVGbEMxc1lOUCtUOXpsaElzMkJ3WERrPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiIxNzEyMTkwMy1kM2JlLTRhZTktODZiZS04YjhkZDRmYzY0ZTYiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLmV1LWNlbnRyYWwtMS5hbWF6b25hd3MuY29tXC9ldS1jZW50cmFsLTFfaGh6MnVJQ2xIIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjp0cnVlLCJjdXN0b206aXZ5X29yZ19pZCI6IjY2IiwiY29nbml0bzp1c2VybmFtZSI6Im4uZ29lbEBlcGlsb3QuY2xvdWQiLCJjdXN0b206aXZ5X3VzZXJfaWQiOiI4MjYwMiIsImF1ZCI6ImdqOXAwanJlaWh0cTAwY3JpNmEwZmUzMDYiLCJldmVudF9pZCI6IjMxZDFhYzU5LTA0NjEtNGU2Ni1hYTk2LThjMzhiMDQ1ODQwOCIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNzY4NDc5OTk1LCJleHAiOjE3Njg0ODM1OTUsImlhdCI6MTc2ODQ3OTk5NSwiZW1haWwiOiJuLmdvZWxAZXBpbG90LmNsb3VkIn0.bzIoJ8Lp3QX95KGyHKIx9Zh7SDJPn-2vRQmqp5eqU3PHdMpgjpfZrQobObgE_jMfiUrr_9W_7meFqRsWgIRonp2Jul_DbHwXikuFSvClk9UpjMuGlG94cmDVdqfTG3WALtWuxoh2R0y74Z0rtFw--R0BrCnLQN0EyW4R62dORLfeFa1teioxY5Im3k0NkybSDjxhE9YQN8djLEYRf4wcRVhXn4Os-34Ey2fb_E8ulHtRR2KQ5x3l7cFBRghWJZxQpUwl5X6Kb1lBgH_ojwV2kAf0wejbtW3Vq5Zj5aviWRrz-G9cUikTuHN3OI46WYWwy8PfcSl-vocJ2SGMh-zADQ"
}