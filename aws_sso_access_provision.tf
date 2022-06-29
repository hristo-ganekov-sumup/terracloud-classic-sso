# Create AdministratorAccess permission set
module "admin_permission" {
  source = "github.com/sumup/fleet//modules/aws_sso/modules/sso_permission_set?ref=9a90e7e2ff0ef443860db84c8ac7a37dbe1a75d2"

  name               = "AdministratorAccess"
  description        = "Give a user full admininstrator access to an account"
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  session_duration   = "PT8H"
}

data "aws_organizations_organization" "org" {}

data "aws_organizations_organizational_units" "ou" {
  parent_id = data.aws_organizations_organization.org.roots[0].id
}

locals {
  ou = { for ou in data.aws_organizations_organizational_units.ou.children: ou.name => ou.id }
}



# https://github.com/hashicorp/terraform-provider-aws/pull/18589
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account 
# have no corresponding data this prevents a native terraform way of answering the question which account IDs are part of this organizational unit
data "external" "ou" {
  for_each = local.ou_to_group_map
   program = ["bash", "${path.module}/ou.sh"]
    query = {
    OUID = local.ou[each.key]
  }

}


# Attach Permission set to OU
module "admins_full_assignment" {
  source = "github.com/sumup/fleet//modules/aws_sso/modules/sso_assignments?ref=9a90e7e2ff0ef443860db84c8ac7a37dbe1a75d2"
  for_each = local.ou_to_group_map

  group_name         = each.value
  permission_set_arn = module.admin_permission.permission_set.arn
  target_account_ids = keys(data.external.ou[each.key].result)
}