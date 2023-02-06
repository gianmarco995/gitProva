resource "openstack_identity_role_assignment_v3" "role_assignment_1" {
  user_id    = openstack_identity_user_v3.user_1.id
  project_id = openstack_identity_project_v3.caso2.id
  role_id    = "f846228183224606a0f49b4134e82241" #_member_
}

resource "openstack_identity_role_assignment_v3" "role_assignment_2" {
  user_id    = "dc75b9ae530d439e91cb90e32244cda5"
  project_id = openstack_identity_project_v3.caso2.id
  role_id    = "fcd157166d8f48839c26ca3ffd8c2bf5" #admin
}

