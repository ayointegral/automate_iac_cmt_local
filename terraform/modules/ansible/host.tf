resource "ansible_host" "host" {
  name   = "supernova"
  groups = [ansible_group.group.name]
}
