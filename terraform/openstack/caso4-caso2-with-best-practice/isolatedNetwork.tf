#isolatedNetwork.tf
#Creo la rete isolata e
#Creo la rete
resource "openstack_networking_network_v2" "network_1" {
  name           = var.openstack_network_1_name
  admin_state_up = "true"

}
resource "openstack_networking_subnet_v2" "subnet_1" {
  name       = var.openstack_subnet_1_name
  network_id = openstack_networking_network_v2.network_1.id
  cidr       = var.openstack_subnet_1_ip
  ip_version = 4
}

#Creo un router
resource "openstack_networking_router_v2" "router_1" {

  name                = var.openstack_router_1_name
  admin_state_up      = true
  external_network_id = var.openstack_network_DMZ_IT_id ##id della 42
}

resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id = openstack_networking_router_v2.router_1.id
  subnet_id = openstack_networking_subnet_v2.subnet_1.id
}

