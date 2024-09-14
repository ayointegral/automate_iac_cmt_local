resource "ansible_vault" "secrets" {
  vault_file          = "/Users/ayodele/Workspace/automation/terraform/modules/ansible/vault.yml"
  vault_password_file = "/Users/ayodele/Workspace/automation/ansible_vault_password.txt"
}
