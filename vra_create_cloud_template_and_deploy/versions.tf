terraform {
  required_providers {
    vra = {
      source  = "vmware/vra"
      version = ">=0.5.2"
    }
  }
  required_version = ">= 0.13"
}