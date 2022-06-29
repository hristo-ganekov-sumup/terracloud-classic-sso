locals {
  group_to_ou = {
    "Sofia WiFi users" = "testou"
  }

  all_groups_all_members_ids = { for grp in data.azuread_group.s: grp.display_name => grp.members }
}

data "azuread_users" "fromgroups" {
  object_ids = flatten(values(local.all_groups_all_members_ids))
}


//Just to make sure they all exist and to throw error if not
data "azuread_groups" "alllisted" {
  display_names = keys(local.group_to_ou)
}

//To have a separate named handler over the groups
data "azuread_group" "s" {
  for_each = toset(data.azuread_groups.alllisted.display_names)
  display_name     = each.key
}
