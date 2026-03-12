terraform {
  required_providers {
    epilot-erp-integration = {
      source  = "epilot-dev/epilot-erp-integration"
      version = "0.21.1"
    }
  }
}


# 66
# eyJraWQiOiJ2ZFR0MGQrK1RMc2FQZ2tsQ3AzMDVGbEMxc1lOUCtUOXpsaElzMkJ3WERrPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiIxNzEyMTkwMy1kM2JlLTRhZTktODZiZS04YjhkZDRmYzY0ZTYiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLmV1LWNlbnRyYWwtMS5hbWF6b25hd3MuY29tXC9ldS1jZW50cmFsLTFfaGh6MnVJQ2xIIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjp0cnVlLCJjdXN0b206aXZ5X29yZ19pZCI6IjY2IiwiY29nbml0bzp1c2VybmFtZSI6Im4uZ29lbEBlcGlsb3QuY2xvdWQiLCJjdXN0b206aXZ5X3VzZXJfaWQiOiI4MjYwMiIsImF1ZCI6ImdqOXAwanJlaWh0cTAwY3JpNmEwZmUzMDYiLCJldmVudF9pZCI6ImY3NDlkM2NiLTc4NjEtNDMyMC1hNDdhLTcwM2RmM2IzNDlhYSIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNzczMzA3MDU0LCJleHAiOjE3NzMzMTA2NTUsImlhdCI6MTc3MzMwNzA1NSwiZW1haWwiOiJuLmdvZWxAZXBpbG90LmNsb3VkIn0.iWiDB8p0Qu3x8eYuJ62UebxCkoDG3YXZDD7vYaq8SMpFtMYE_HJdEEHvsVLCmUftAx4ysRfXchS9MBof2ST5oXxF_XUsYyBSYbrzefKfg1Mgh_wKlP1Eic9SU64qDEm5PCfZ9Dhj-f6R7rarYvmEpFFhF2KCUkscP5RCHL6xWn8lSG6h4xtbJ8c8a5rvOAS649-9tiqNRFCi2jsZP2B43-plM7V4cVG1ubEiNK4Xib68XGM91Ml-yH3U0vnH8fA99sk1s4VGBQx1txVQiblOGWQykOrc9129V7DgiPZPjYGuQtfRNTT1KkY9n6vOuAyJ72oibJM5LS3fLW-xARplIA

provider "epilot-erp-integration" {
  epilot_auth = "eyJraWQiOiJnSUdCSVlDVGtnR0p2THliME1cL1Q2TDJ4YlhKVzdOV3E5M2xMbHVcL1p5bGM9IiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiI3Mzk0NzgyMi1lMGYxLTcwOTEtODQ4OS0wYjI1MzY0MzgzYzMiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLmV1LWNlbnRyYWwtMS5hbWF6b25hd3MuY29tXC9ldS1jZW50cmFsLTFfVXUxVGx1dUxnIiwiY3VzdG9tOml2eV9vcmdfaWQiOiIyMDAwMDIxOCIsImNvZ25pdG86dXNlcm5hbWUiOiJ3ZW1hZ25ldHpAdGVzdHVzZXIuZXBpbG90LmNsb3VkIiwiY3VzdG9tOml2eV91c2VyX2lkIjoiMTYxNjIwIiwib3JpZ2luX2p0aSI6ImE1ZGI3ZDUxLWYyMzAtNDkyMS1hOGM4LWM5ZTM0NzMzNzJmMyIsImF1ZCI6IjZicDByaDcxZzFxajBuMWFiZzN2b3I3YXZnIiwiZXZlbnRfaWQiOiJmMDA3NDUyMS1lMTQ4LTQ4MTctOTc4Mi0wYzIzNjBmYzEwNzkiLCJ0b2tlbl91c2UiOiJpZCIsImF1dGhfdGltZSI6MTc3MzMzNDE5NSwiZXhwIjoxNzczMzM3Nzk3LCJpYXQiOjE3NzMzMzQxOTcsImp0aSI6ImI1ZDExOGNjLTg0NzAtNDExZS1iNmQ1LWQwMGFjYWFkOTA0MSIsImVtYWlsIjoid2VtYWduZXR6QHRlc3R1c2VyLmVwaWxvdC5jbG91ZCJ9.kY4BDNxKHcFs5Q_zsk-NS028E3RykNHwTm7SVRSslENDlN_X_ZkEmnyjjlCIzPAAwtCxH2xGOuhBsnAiHilcA_1m158HxoLfu2TTvCj_S13ZhHAD-d_dcWUDX0sZ2Sgb3Bu9YKoPBWd2mjlZDPywLLPSo0F4PsYLNe8Y4XYH2lWJmryKjAX2FRSgSSuwurpPv5ARoafj0GZK2FNV-Y0UeCTHznWGWK3llxbPY3H53rlqxJoQql1VSQDlKuHxsB8avzKSY2ilM8xKO8IXRlR-6p4jHvnbdgHoF5-US33bp3ufBxywP0aCPfSS2NXAejmzpfhjTpkRirr6AnLsTmTmTw" # Required
}



# epilot-erp-integration_integration.integration_74a4aa68b35c4570be8aa15315b13b01:
# resource "epilot-erp-integration_integration" "integration_74a4aa68b35c4570be8aa15315b13b01" {
#     name       = "WEMAG EVI - without outbound"
#     use_cases  = [
#         {
#             inbound = {
#                 change_description = "Configuration updated"
#                 configuration      = {
#                     entities       = [
#                         {
#                             enabled       = {
#                                 boolean = true
#                             }
#                             entity_schema = "contract"
#                             fields        = [
#                                 {
#                                     attribute = "contract_number"
#                                     field     = "customerAccountNumber"
#                                 },
#                                 {
#                                     attribute = "installment_amount"
#                                     field     = "amount"
#                                 },
#                             ]
#                             unique_ids    = [
#                                 "contract_number",
#                             ]
#                         },
#                     ]
#                     meter_readings = []
#                 }
#                 enabled            = true
#                 name               = "BillingPlanChange_ARBEITSTITEL"
#                 type               = "inbound"
#             }
#         },
#     ]
# }


# import {
#   to = epilot-erp-integration_integration.wemag
#   id = "1570e006-8c7b-47b3-ad6a-6e46209cf21b"
# }

# resource "epilot-erp-integration_integration" "wemags" {}
# 1570e006-8c7b-47b3-ad6a-6e46209cf21b