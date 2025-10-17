provider "azurerm" {

  features {

  }

}

resource "azurerm_resource_group" "miniFinance-rg" {
  name = "${var.prefix}-rg"
  location = var.region
}

module "network" {
  source               = "git::https://github.com/imshakil/infra-with-terraform.git//epicbook-deployment/modules/network"
  resource_group       = azurerm_resource_group.miniFinance-rg.name
  region               = azurerm_resource_group.miniFinance-rg.location
  vnet_cidr            = var.vnet_cidr
  prefix               = var.prefix
  public_subnet1_cidr  = var.vnet_cidr_public_sub1
  private_subnet1_cidr = var.vnet_cidr_private_sub1

}

module "vm" {
  source = "../../automation-on-azure/terraform/modules/vm"
  prefix = var.prefix
  resource_group = azurerm_resource_group.miniFinance-rg.name
  region = var.region
  subnet_id = module.network.public_subnet1_id
  ssh_key_path = var.ssh_key_path
  vm_admin = var.vm_admin

}

resource "null_resource" "generate_inventory" {
  depends_on = [module.vm]

  provisioner "local-exec" {
    command = <<EOT
#!/bin/bash
set -e

cat > ../ansible/inventory.ini <<EOF
[app]
${module.vm.vm_public_ip}

[all:vars]
ansible_user=${var.vm_admin}
ansible_ssh_private_key_file=~/.ssh/id_rsa
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
EOF

echo "Inventory file generated at ../ansible/inventory.ini"
EOT
  }

  triggers = {
    public_ip = module.vm.vm_public_ip
  }

}
