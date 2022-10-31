provider "vra" {
  url           = var.vra_url
  refresh_token = var.vra_refresh_token
  insecure      = false
}

data "vra_project" "this" {
  id = var.project_id
}

data "vra_region" "this" {
  id = var.region_id
}

resource "vra_deployment" "this" {
  name        = var.deployment_name
  description = var.deployment_description
  catalog_item_id      = var.catalog_item_id
  project_id           = var.project_id

  inputs = {
    usrname = "test01"
    pswrd  = "centos"
  }

  timeouts {
    create = "30m"
    delete = "30m"
    update = "30m"
  }
}