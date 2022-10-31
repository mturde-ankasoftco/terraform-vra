provider "vra" {
  url           = var.vra_url
  refresh_token = var.vra_refresh_token
  insecure      = false
}

data "vra_project" "this" {
  id = var.vra_project_id
}

data "vra_region" "this" {
  id = var.vra_region_id
}

# Create a new Blueprint
resource "vra_blueprint" "this" {
  name        = "CentOS79"
  description = "Created by vRA terraform provider"
  project_id = data.vra_project.this.id

  content = <<-EOT
formatVersion: 1
inputs:
  Flavor:
    type: string
    title: Flavor
    enum:
      - x-small
      - large
      - medium
      - small
  Image:
    type: string
    title: Image
    enum:
      - centOS79
      - centOS8
resources:
  Web_Server:
    type: Cloud.Machine
    properties:
      image: '$${input.Image}'
      flavor: '$${input.Flavor}'
      cloudConfig: |
        users:
          - name: sam
            ssh-authorized-keys:
              - 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAJhmOeILoSyY2ke8oQu1pJ8td12ReCFbc5ZQflXcxYoTcUp00CLKrvdQzrOnOJAUGR0QOjp/2LxvOgq0lR0g3qSOX9Cg+wTxpOKP/VQRw9+SWv625bbAk3R6VSzIG83XJ24MPwmsa9wPgaU4cCc9SmXzKJEQGtAd9QNyO2c5fxEynZUsZbbQiNtZbliA0lyU3dAnPOofdhJ6I6aV2YFvp4juy9NdaNuR7HUTwyUfMOvilcTzdsJ/dJrc9Ypl427vgZk4opmlikVBLlWvJdBLt8PgPpl4GWgkg+WBqPUu33ExB6MfWNvXUjC3u1D9sokJwQw4NBXvvQHg4Dpf+IP75'
            sudo:
              - 'ALL=(ALL) NOPASSWD:ALL'
            groups: sudo
            shell: /bin/bash
  EOT
}


resource "vra_deployment" "this" {
  name        = "Terraform Deployment"
  description = "Deployed from vRA provider for Terraform."

  blueprint_id      = vra_blueprint.this.id
  project_id        = vra_project.this.id

  inputs = {
    Flavor = "small"
    Image  = "centOS79"
  }
}