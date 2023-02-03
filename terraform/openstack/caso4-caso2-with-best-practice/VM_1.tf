#isolatedNetworkBaseVM.tf
#Creo la porta, il security group con le sue rule da associarvi
#Security group
resource "openstack_compute_secgroup_v2" "secgroup_1" {
  name        = var.openstack_secgroup_1_name
  description = "a security group"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}
#creo la porta associando rete e security group
resource "openstack_networking_port_v2" "port_vm_1" {
  name               = var.openstack_port_vm_1_name
  network_id         = openstack_networking_network_v2.network_1.id
  admin_state_up     = "true"
  security_group_ids = ["${openstack_compute_secgroup_v2.secgroup_1.id}"]

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.subnet_1.id
    ip_address = var.openstack_port_vm_1_ip
  }
}

#Creo la VM con la porta specificata prima
resource "openstack_compute_instance_v2" "vm_1" {

  name            = var.openstack_vm_1_name
  image_id        = var.openstack_image_ubuntu
  flavor_id       = "2"
  security_groups = ["default"]


  network {
    port = openstack_networking_port_v2.port_vm_1.id
  }

}

