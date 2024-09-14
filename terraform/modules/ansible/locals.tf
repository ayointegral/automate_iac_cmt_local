locals {
  decoded_vault_yaml = yamldecode(ansible_vault.secrets.yaml)
  vault_map          = { for k, v in local.decoded_vault_yaml : k => tostring(v) }
}
