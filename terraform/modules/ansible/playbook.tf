resource "ansible_playbook" "playbook" {
  name       = "web"
  replayable = true
  playbook   = "/Users/ayodele/Workspace/automation/terraform/modules/ansible/playbook.yml"
  extra_vars = local.vault_map
}
