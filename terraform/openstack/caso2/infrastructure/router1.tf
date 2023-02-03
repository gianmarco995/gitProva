#Creo un router
resource "openstack_networking_router_v2" "router_1" {

  name                = "my_router"
  admin_state_up      = true
  external_network_id = "d4c5e936-dd41-4374-8d86-538fef9826d5" ##id della 42
}

resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id = openstack_networking_router_v2.router_1.id
  subnet_id = openstack_networking_subnet_v2.subnet_1.id
}


