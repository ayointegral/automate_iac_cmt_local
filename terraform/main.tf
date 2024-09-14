module "ansible" {
  source = "./modules/ansible"
}

terraform {
  required_providers {
    ansible = {
      version = "~> 1.3.0"
      source  = "ansible/ansible"
    }
  }
}
