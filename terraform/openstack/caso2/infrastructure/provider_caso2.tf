# Provider Custom del nuovo progetto
#Auth URL la porta 5000 è quella di keystone (l'auth server di Openstack)
provider "openstack" {
  user_name   = "gianmarcomoretti"
  tenant_name = "caso2"
  password    = "Ottobre20"
  auth_url    = "http://192.168.11.100:5000"
  region      = "bologna-1"
}

