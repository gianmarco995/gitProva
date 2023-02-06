
#Creo i Flavor
resource "openstack_compute_flavor_v2" "flavor-corso" {
  name  = "flavor venanzi"
  ram   = "8096"
  vcpus = "4"
  disk  = "40"
}

resource "openstack_compute_flavor_access_v2" "access_1" {
  tenant_id = "25d795e859dc4275993fbaf63b27c6c3"
  flavor_id = openstack_compute_flavor_v2.flavor-corso.id
}
