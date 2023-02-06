#project.tf

resource "openstack_identity_project_v3" "caso4" {
  name        = var.openstack_project_name
  description = "progetto di esempio "
}

#member.tf
resource "openstack_identity_user_v3" "member_1" {
  default_project_id                    = openstack_identity_project_v3.caso4.id
  name                                  = var.openstack_member_1_name
  description                           = var.openstack_member_1_description
  password                              = var.openstack_member_1_password
  ignore_change_password_upon_first_use = true
}


#caso2roleAssignment.tf
resource "openstack_identity_role_assignment_v3" "role_assignment_1" {
  user_id    = openstack_identity_user_v3.user_1.id
  project_id = openstack_identity_project_v3.caso2.id
  role_id    = var.openstack_roleid_member #_member_
}
##Ruolo profilo gianmarco come admin
resource "openstack_identity_role_assignment_v3" "role_assignment_2" {
  user_id    = var.openstack_userID_gianmarcomoretti
  project_id = openstack_identity_project_v3.caso2.id
  role_id    = var.openstack_roleid_admin #admin
}

