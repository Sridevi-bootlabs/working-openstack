

#project creation
resource "openstack_identity_project_v3" "openstack_project_1" {
  name        = "myproject"
}
#user creation

resource "openstack_identity_user_v3" "user_1" {
  default_project_id = openstack_identity_project_v3.openstack_project_1.id
  name               = "myuser"
  description        = "A user"

  password = "password@123"

  ignore_change_password_upon_first_use = true

  multi_factor_auth_enabled = true

  multi_factor_auth_rule {
    rule = ["password"]
  }

  extra = {
    email = "sridevi@bootlabstech.com"
  }
}
#role
resource "openstack_identity_role_v3" "role_1" {
  name = "myrole"
}

resource "openstack_identity_role_assignment_v3" "role_assignment_1" {
  user_id    = openstack_identity_user_v3.user_1.id
  project_id = openstack_identity_project_v3.openstack_project_1.id
  role_id    = openstack_identity_role_v3.role_1.id
}







# networking
resource "openstack_networking_network_v2" "network_1" {
  name           = "mynetwork"
  admin_state_up = "true"
  external       = "true"
  # segments {
  #   network_type     = "flat"
  #   physical_network = "physnet1"
  # }
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  name       = "mysubnet"
  network_id = openstack_networking_network_v2.network_1.id
  cidr       = "10.0.4.0/24"
  ip_version = 4

}

resource "openstack_networking_router_v2" "external-router" {
  name                = "myrouter"
  admin_state_up      = true
  # external_network_id = openstack_networking_network_v2.network_1.id
}
resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id = openstack_networking_router_v2.external-router.id
  subnet_id = openstack_networking_subnet_v2.subnet_1.id
}

# resource "openstack_compute_flavor_v2" "small-flavor" {
#   name      = "mysmall"
#   ram       = "4096"
#   vcpus     = "1"
#   disk      = "0"
#   flavor_id = "2"
#   is_public = "true"
# }
# data "openstack_compute_flavor_v2" "small" {
#   vcpus = 1
#   ram   = 4000
# }
# resource "openstack_compute_instance_v2" "test_host" {
#   count =  1
#   name = "mmuinsta"
#   image_name = "${var.image}"
#   flavor_id = data.openstack_compute_flavor_v2.small.id
#   key_pair = "key"

#   # network {
#   #   port = openstack_networking_port_v2.port_1.id
#   # }
#  }






# resource "openstack_networking_network_v2" "network_1" {
#   name           = "network_1"
#   admin_state_up = "true"
# }

# resource "openstack_compute_instance_v2" "instance_1" {
#   name            = "instance_1"
#   #   name = "myinstance"
#   image_name = "${var.image}"
#   flavor_name = "${var.flavor}"
#   security_groups = ["default"]
# }

# resource "openstack_compute_interface_attach_v2" "ai_1" {
#   instance_id = openstack_compute_instance_v2.instance_1.id
#   network_id  = openstack_networking_port_v2.port_1.id
# }

# resource "openstack_networking_port_v2" "port_1" {
#   name           = "port_1"
#   network_id     = openstack_networking_network_v2.network_1.id
#   admin_state_up = "true"
# }
# resource "openstack_images_image_v2" "rancheros" {
#   name             = "RancherOS"
#   image_source_url = "https://releases.rancher.com/os/latest/rancheros-openstack.img"
#   container_format = "bare"
#   disk_format      = "qcow2"
#   visibility = "public"

#   properties = {
#     key = "new"
#   }
# }
resource "openstack_images_image_v2" "Ubuntu" {
  name             = "ubuntu"
  image_source_url = "https://cloud-images.ubuntu.com/."
  container_format = "bare"
  disk_format      = "qcow2"
  visibility = "public"

}

# resource "openstack_images_image_v2" "windows_image" {
#   name            = "windows-server-image"
#   container_format = "bare"
#   disk_format     = "qcow2"
#   # Add other image attributes as needed
# }
# resource "openstack_compute_image" "ubuntu_image" {
#   name            = "ubuntu-22.04-lts"
#   container_format = "bare"
#   disk_format     = "qcow2"
#   url             = "https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64.qcow2"

#   # (Optional) Additional metadata
#   visibility = "public"
#   tags       = ["ubuntu", "lts"]
#   properties = {
#     architecture = "x86_64"
#     distribution = "Ubuntu"
#     version      = "22.04"
#   }
# }



resource "openstack_compute_instance_v2" "vm1" {
  # count = "1"
  name = "sailor-openstack"
  image_name = openstack_images_image_v2.Ubuntu.name
  flavor_name = "${var.flavor}"
  security_groups =  ["default"]
   network {
    uuid = openstack_networking_network_v2.network_1.id
  }
  }




