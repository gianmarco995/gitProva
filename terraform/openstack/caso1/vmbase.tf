resource "openstack_compute_instance_v2" "basic" {
  name            = "vmbase"
  image_id        = "266f2fcb-14e8-4ff2-be0c-6ca303a101da"
  flavor_id       = "2"
  security_groups = ["default"]


  network {
    name = "PILOTA-DMZ-IT"
  }

}
