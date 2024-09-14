# Automation Setup Guide

This project automates the creation, configuration, and management of virtual machines (VMs) using **Vagrant** and **Ansible**. You can optionally extend this automation by integrating **Terraform** for provisioning cloud infrastructure. VMs are configured to install Python, Docker, and Nginx for application deployment.

## Table of Contents

- [Automation Setup Guide](#automation-setup-guide)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Project Structure](#project-structure)
  - [How to Use](#how-to-use)
    - [Step 1: Start the Vagrant Machines](#step-1-start-the-vagrant-machines)
    - [Step 2: Run the Ansible Playbook](#step-2-run-the-ansible-playbook)
    - [Step 3: Managing the Machines](#step-3-managing-the-machines)
    - [Step 4: Ansible Vault Management](#step-4-ansible-vault-management)
    - [Step 5: Testing the Roles](#step-5-testing-the-roles)
    - [Optional: Using Terraform to Run Ansible](#optional-using-terraform-to-run-ansible)
  - [Terraform Integration](#terraform-integration)
  - [Scripts](#scripts)
  - [Troubleshooting](#troubleshooting)

## Prerequisites

Before running this project, make sure the following tools are installed:

1. [Vagrant](https://www.vagrantup.com/downloads) (for local VMs)
2. [Virtualization Provider](https://www.vagrantup.com/docs/providers) (e.g., VirtualBox, Parallels, etc.)
3. [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html) (for configuration management)
4. [Terraform](https://www.terraform.io/downloads.html) (optional for provisioning cloud resources)
5. [Python3](https://www.python.org/downloads/) (required for running tests and Ansible)

## Project Structure

```bash
.
├── ansible/                     # Ansible configuration
│   ├── ansible.cfg              # Ansible configuration file
│   ├── ansible.log              # Log file for Ansible operations
│   ├── group_vars/              # Variables for all hosts
│   │   └── all/
│   │       └── vault.yml        # Encrypted sensitive variables using Ansible Vault
│   ├── host_vars/               # Host-specific variables
│   │   ├── cosmos.yml
│   │   ├── nebula.yml
│   │   ├── pulsar.yml
│   │   ├── quasar.yml
│   │   └── supernova.yml
│   ├── inventory/
│   │   └── hosts                # Inventory file for defining the hosts
│   ├── playbooks/
│   │   └── site.yml             # Main Ansible playbook
│   └── roles/                   # Ansible roles
│       ├── docker/              # Docker role
│       ├── nginx/               # Nginx role
│       ├── python/              # Python installation role
│       ├── python3/             # Python3-specific role
│       └── mdklatt.tmpdir/      # External role for managing temp dirs
├── scripts/                     # Helper scripts
│   ├── manage_ansible.sh        # Script to manage Ansible
│   └── manage_vagrant.sh        # Script to manage Vagrant
├── terraform/                   # Terraform configuration (optional)
│   ├── main.tf
│   ├── playbook.yml
│   └── variables.tf
└── vagrant/
    └── Vagrantfile              # Vagrant configuration file
```

## How to Use

### Step 1: Start the Vagrant Machines

You can start the VMs by running the provided `manage_vagrant.sh` script:

```bash
./scripts/manage_vagrant.sh up
```

### Step 2: Run the Ansible Playbook

Run the Ansible playbook to install Python, Docker, and Nginx on the VMs:

```bash
./scripts/manage_ansible.sh run
```

### Step 3: Managing the Machines

- **Ping All VMs**:

```bash
ansible all -i ansible/inventory/hosts -m ping
```

- **Check Logs**:

```bash
cat ansible/ansible.log
```

### Step 4: Ansible Vault Management

To manage sensitive variables in `vault.yml`, use Ansible Vault:

- **Encrypt Variables**:

```bash
ansible-vault encrypt ansible/group_vars/all/vault.yml
```

- **Edit Vault**:

```bash
ansible-vault edit ansible/group_vars/all/vault.yml
```

### Step 5: Testing the Roles

Some roles have testing configurations (e.g., `python3`). To run these tests:

```bash
cd ansible/roles/python3/tests
pytest
```

### Optional: Using Terraform to Run Ansible

1. **Initialize Terraform**:

```bash
cd terraform
terraform init
```

2. **Apply the Terraform Plan**:

```bash
terraform apply
```

This will provision the infrastructure and trigger the Ansible playbook using `local-exec`.

## Terraform Integration

Terraform is integrated to provision cloud infrastructure. Modify `variables.tf` and `main.tf` to match your environment. The `playbook.yml` in the `terraform/` directory ensures Ansible is executed post-provisioning.

## Scripts

1. **`manage_vagrant.sh`** – Used to manage the lifecycle of Vagrant VMs (up, halt, destroy).
2. **`manage_ansible.sh`** – Used to execute Ansible playbooks.

## Troubleshooting

- **Python Version Issues**: Ensure the correct Python version is installed on the VMs.
- **VM Issues**: Verify that the virtualization provider (e.g., VirtualBox, Parallels) is correctly installed.
