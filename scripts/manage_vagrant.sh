#!/bin/bash

VAGRANT_DIR="vagrant"

# Function to bring up the Vagrant machines and provision them
vup() {
  echo "Starting and provisioning Vagrant machines..."
  cd $VAGRANT_DIR
  for vm in nebula cosmos quasar pulsar supernova; do
    if [ "$1" == "all" ] || [ "$1" == "$vm" ]; then
      VM=$vm vagrant up
      echo "Provisioning $vm..."
      VM=$vm vagrant provision
    fi
  done
  cd - # Go back to the previous directory
}

# Function to bring down the Vagrant machines
vdown() {
  echo "Halting Vagrant machines..."
  cd $VAGRANT_DIR
  for vm in nebula cosmos quasar pulsar supernova; do
    if [ "$1" == "all" ] || [ "$1" == "$vm" ]; then
      VM=$vm vagrant halt
    fi
  done
  cd - # Go back to the previous directory
}

# Function to destroy the Vagrant machines
vdestroy() {
  echo "Destroying Vagrant machines..."
  cd $VAGRANT_DIR
  for vm in nebula cosmos quasar pulsar supernova; do
    if [ "$1" == "all" ] || [ "$1" == "$vm" ]; then
      VM=$vm vagrant destroy -f
    fi
  done
  cd - # Go back to the previous directory
}

# Function to reload the Vagrant machines and provision them
vreload() {
  echo "Reloading and provisioning Vagrant machines..."
  cd $VAGRANT_DIR
  for vm in nebula cosmos quasar pulsar supernova; do
    if [ "$1" == "all" ] || [ "$1" == "$vm" ]; then
      VM=$vm vagrant reload
      echo "Provisioning $vm..."
      VM=$vm vagrant provision
    fi
  done
  cd - # Go back to the previous directory
}

# Main script logic to handle input arguments
case "$1" in
  vup)
    vup "$2"
    ;;
  vdown)
    vdown "$2"
    ;;
  vdestroy)
    vdestroy "$2"
    ;;
  vreload)
    vreload "$2"
    ;;
  *)
    echo "Usage: $0 {vup|vdown|vdestroy|vreload} [vm_name|all]"
    exit 1
esac
