provider "vra" {
  url           = var.vra_url
  refresh_token = var.vra_refresh_token
  insecure      = false
}

data "vra_region" "this" {
  id = var.vra_region_id
}

resource "vra_flavor_profile" "my-vsphere-flavor-profile" {
  name        = "terraform-flavour-profile"
  description = "Flavor profile created by Terraform"
  region_id   = data.vra_region.this.id

  flavor_mapping {
    name          = "small"
    cpu_count = 2
    memory = 2048
  }

  flavor_mapping {
    name          = "medium"
    cpu_count = 4
    memory = 4096
  }
}