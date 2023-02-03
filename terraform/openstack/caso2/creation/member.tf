resource "openstack_identity_user_v3" "user_1" {
  default_project_id                    = openstack_identity_project_v3.caso2.id
  name                                  = "francescomeoni"
  description                           = "Responsabile linea pilota"
  password                              = "password123"
  ignore_change_password_upon_first_use = true
  extra                                 = { email = "francesco.meoni@bi-rex.it" }
}

