variable "openstack_user_name" {
  description = "The username for the Tenant."
}

variable "openstack_tenant_name" {
  description = "The name of the Tenant."
}

variable "openstack_password" {
  description = "The password of the user "
}

variable "openstack_auth_url" {
  description = "The endpoint url to connect to OpenStack."
}

variable "openstack_region_name" {
  description = "The username for the Tenant."
}

variable "openstack_network_1_name" {
  description = "nome della rete isolata"
}
variable "openstack_subnet_1_name" {
  description = "nome della subnet isolata"
}
variable "openstack_subnet_1_ip" {
  description = "ip associato alla subnet"
}
variable "openstack_network_DMZ_IT_id" {
  description = "id staticamente fissato da openstack per la rete 42"
}
variable "openstack_secgroup_1_name" {
  description = "nome della sec group "
}
variable "openstack_port_vm_1_name" {
  description = "nome della porta 1 associata lla VM1"
}
variable "openstack_port_vm_1_ip" {
  description = " ip della porta 1 su vm1, da scegliere tra quelli della subnet "
}
variable "openstack_vm_1_name " {
  description = " nome della vm1 "
}
variable "openstack_image_ubuntu" {
  description = " id statico immagine di ubuntu 20.04"
}




