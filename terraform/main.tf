terraform {
  required_providers {
    ansible = {
      version = "~> 1.3.0"
      source  = "ansible/ansible"
    }
  }
}

resource "ansible_vault" "secrets" {
  vault_file          = "~/Workspace/automation/ansible/group_vars/all/vault.yml"
  vault_password_file = "~/Workspace/automation/ansible_vault_password.txt"
}

locals {
  decoded_vault_yaml = yamldecode(ansible_vault.secrets.yaml)
  vault_map          = { for k, v in local.decoded_vault_yaml : k => tostring(v) }
}

output "decoded_vault_yaml" {
  value     = local.decoded_vault_yaml
  sensitive = true
}

resource "ansible_host" "host" {
  name   = "supernova"
  groups = [ansible_group.group.name]
}

resource "ansible_group" "group" {
  name = "web"
}

resource "ansible_playbook" "playbook" {
  name       = "web"
  replayable = true
  playbook   = "playbook.yml"
  extra_vars = local.vault_map
}