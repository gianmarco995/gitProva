#isolatedNetwork.tf
#Creo la rete isolata e
#Creo la rete
resource "openstack_networking_network_v2" "network_1" {
  name           = "network_1"
  admin_state_up = "true"

}
