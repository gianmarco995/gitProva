#isolatedNetworkBaseVM.tf
#Creo la porta, il security group con le sue rule da associarvi
#Security group
resource "openstack_compute_secgroup_v2" "secgroup_1" {
  name        = "secgroup_1"
  description = "a security group"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}
#creo la porta associando rete e security group
resource "openstack_networking_port_v2" "port_1" {
  name               = "port_1"
  network_id         = openstack_networking_network_v2.network_1.id
  admin_state_up     = "true"
  security_group_ids = ["${openstack_compute_secgroup_v2.secgroup_1.id}"]

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.subnet_1.id
    ip_address = "10.0.100.100"
  }
}

#Creo la VM con la porta specificata prima
resource "openstack_compute_instance_v2" "vmCaso2" {

  name            = "Caso2vmbase"
  image_id        = "266f2fcb-14e8-4ff2-be0c-6ca303a101da"
  flavor_id       = "2"
  security_groups = ["default"]


  network {
    port = openstack_networking_port_v2.port_1.id
  }

}

