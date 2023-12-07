variable "openstack_user_name" {}
# variable "openstack_tenant_name" {}
variable "openstack_password" {}
variable "openstack_auth_url" {}
variable "image" {
  default = "cirros"
}
variable "flavor" {
  default = "m4.large"
}

variable "ssh_key_pair" {
  default = "mykey"
}

variable "ssh_user_name" {
  default = "root"
}








