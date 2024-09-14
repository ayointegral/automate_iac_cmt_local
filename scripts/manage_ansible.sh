#!/bin/bash

# Define paths relative to the script's location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ANSIBLE_DIR="$SCRIPT_DIR/../ansible"
INVENTORY_FILE="$ANSIBLE_DIR/inventory/hosts"
PLAYBOOK_FILE="$ANSIBLE_DIR/playbooks/site.yml"

# Debug: print the paths being used
echo "SCRIPT_DIR: $SCRIPT_DIR"
echo "ANSIBLE_DIR: $ANSIBLE_DIR"
echo "INVENTORY_FILE: $INVENTORY_FILE"
echo "PLAYBOOK_FILE: $PLAYBOOK_FILE"

# Function to run the Ansible playbook
run_playbook() {
  echo "Running Ansible playbook..."
  ansible-playbook -i "$INVENTORY_FILE" "$PLAYBOOK_FILE" -vvvv
}

# Function to test connection with Ansible ping
ping_hosts() {
  echo "Pinging hosts in the inventory..."
  ansible -i "$INVENTORY_FILE" all -m ping -vvvv
}

# Function to view Ansible inventory
show_inventory() {
  echo "Showing inventory..."
  ansible-inventory -i "$INVENTORY_FILE" --list -vvvv
}

# Function to encrypt a file with Ansible Vault
encrypt_vault() {
  if [ -z "$2" ]; then
    echo "Usage: $0 vault_encrypt <file>"
    exit 1
  fi
  echo "Encrypting $2 with Ansible Vault..."
  ansible-vault encrypt "$2" -vvvv
}

# Function to decrypt a file with Ansible Vault
decrypt_vault() {
  if [ -z "$2" ]; then
    echo "Usage: $0 vault_decrypt <file>"
    exit 1
  fi
  echo "Decrypting $2 with Ansible Vault..."
  ansible-vault decrypt "$2" -vvvv
}

# Main script logic to handle input arguments
case "$1" in
  run)
    run_playbook
    ;;
  ping)
    ping_hosts
    ;;
  inventory)
    show_inventory
    ;;
  vault_encrypt)
    encrypt_vault "$2"
    ;;
  vault_decrypt)
    decrypt_vault "$2"
    ;;
  *)
    echo "Usage: $0 {run|ping|inventory|vault_encrypt|vault_decrypt} [file]"
    exit 1
esac
