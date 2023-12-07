terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.53.0"
    }
  }
}

provider "openstack" {
  user_name = "${var.openstack_user_name}"
  tenant_name=  "${var.openstack_user_name}"
  password  = "${var.openstack_password}"
  auth_url  = "${var.openstack_auth_url}"
}