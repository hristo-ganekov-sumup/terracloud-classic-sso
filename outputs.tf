# Outputs
//Deeeeebug
output "groups_selected" {
  value = data.azuread_group.s
}

output "users" {
  value = data.azuread_users.fromgroups
}

output "users_ids" {
  value = flatten(values(local.all_groups_all_members_ids))
}