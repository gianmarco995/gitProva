##Terraform config 
## necessario per dire a terraform dove trovare il modello di provider "Openstak"
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}

# Configure the OpenStack Provider
#Auth URL la porta 5000 è quella di keystone (l'auth server di Openstack)
provider "openstack" {
  user_name   = var.openstack_user_name
  tenant_name = var.openstack_tenant_name
  password    = var.openstack_password
  auth_url    = var.openstack_auth_url
  region      = var.openstack_region_name
}

