# Terraform Ansible Integration Project

This project demonstrates the integration of Terraform with Ansible to manage infrastructure and configuration.

## Project Structure

- **main.tf**: Contains the Terraform configuration, including:
  - Ansible vault resource to decode secrets.
  - Local variables to store decoded YAML values.
  - Ansible host resource that utilizes variables from the decoded vault.
  - The host resource is configured to use hosts defined in the inventory file located at `/path/to/your/inventory/hosts`.

## Requirements

- Terraform
- Ansible

## Usage

1. Ensure that you have the required providers installed.
2. Update the inventory file with the necessary hosts.
3. Run `terraform init` to initialize the project.
4. Execute `terraform apply` to apply the configuration.

## License

This project is licensed under the MIT License.
