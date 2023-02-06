#Creo VM2
resource "openstack_networking_port_v2" "port_vm_2" {

  name            = "port_vm_2"
  network_id      = "0b410e43-9612-4b12-a1a4-fb4df0d9fc99"
  admin_state_up  = "true"
  


  fixed_ip {
    subnet_id  = "ccdfca03-102b-4138-9d2d-ae54c837e12a"
    ip_address = "192.168.44.243"
  }
}



resource "openstack_compute_instance_v2" "corso2" {


  name      = "corsovm2"
  image_id  = "266f2fcb-14e8-4ff2-be0c-6ca303a101da"
  flavor_id = openstack_compute_flavor_v2.flavor-corso.id
  security_groups = ["OPENALL"]
  key_pair = "gianmarcoMoretti"



  network {
    port = openstack_networking_port_v2.port_vm_2.id
  }

}


