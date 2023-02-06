resource "openstack_networking_secgroup_v2" "secgroup_1" {
  name        = var.openstack_secgroup_1_name
  description = "a security group"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_any_TCP" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_1.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_any_UDP" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_1.id}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_any_ICMP" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_1.id}"
}
  



#Creo la porta del server VPN associando rete 
resource "openstack_networking_port_v2" "port_VPN" {
  name               = var.openstack_port_vpn_name
  network_id         = openstack_networking_network_v2.B005N1.id
  admin_state_up     = "true"
  
  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.B005N1S1.id
    ip_address = var.openstack_port_vpn_ip
  }
}

#creo e ASSOCIO il floating ip
resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool = var.openstack_pool_flaoting_ip #Necessario 
  port_id = openstack_networking_port_v2.port_VPN.id
}

resource "openstack_networking_port_secgroup_associate_v2" "associate_VPN_secGroup" {
  port_id = "${openstack_networking_port_v2.port_VPN.id}"
  security_group_ids = [
    "${openstack_networking_secgroup_v2.secgroup_1.id}",
  ]
}

#Creo la VM con la porta specificata prima
resource "openstack_compute_instance_v2" "VPN" {

  name            = var.openstack_vpn_name
  image_id        = var.openstack_image_VPN
  flavor_id       = var.openstack_flavor_vpn

  key_pair        = "gianmarcoMoretti"

  network {
    port = openstack_networking_port_v2.port_VPN.id
  }


}
