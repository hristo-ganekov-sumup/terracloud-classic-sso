# ou_to_group_map variable is a map holding the AWS Sumup organizational units as keys 
# and the corresponding Azure group (being created in SSO) that will be given Administrator access as values
#eg. users in group sysops are given Administrator access to accounts part of itest OU in AWS 
# locals {
#   ou_to_group_map = {
#     "itest" = "sysops"
#   }

locals {
  ou_to_group_map = {
    "itest" = "sysops"
  }

}