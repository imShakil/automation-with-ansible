provider "azurerm" {

  features {

  }
}

resource "azurerm_resource_group" "adhoc-rg" {
  name     = "${var.prefix}-rg"
  location = var.region
}

module "network" {
  source               = "git::https://github.com/imshakil/infra-with-terraform.git//epicbook-deployment/modules/network"
  resource_group       = azurerm_resource_group.adhoc-rg.name
  region               = azurerm_resource_group.adhoc-rg.location
  vnet_cidr            = var.vnet_cidr
  prefix               = var.prefix
  public_subnet1_cidr  = var.vnet_cidr_public_sub1
  private_subnet1_cidr = var.vnet_cidr_private_sub1

}

module "vm" {
  source         = "./modules/vm"
  resource_group = azurerm_resource_group.adhoc-rg.name
  region         = azurerm_resource_group.adhoc-rg.location
  vm_admin       = var.vm_admin
  ssh_key_path   = var.ssh_key_path
  subnet_id      = module.network.public_subnet1_id
  depends_on     = [module.network]
  count          = var.vm_count
  prefix         = "${var.prefix}-vm${count.index}"
}

resource "null_resource" "generate_inventory" {
  provisioner "local-exec" {
    command = <<EOT
#!/bin/bash
set -e

cat > ../ansible/inventory.ini <<EOF
[app]
${module.vm[0].vm_public_ip}

[db]
${module.vm[1].vm_public_ip}

[all:vars]
ansible_user=${var.vm_admin}
ansible_ssh_private_key_file=~/.ssh/id_rsa
EOF

echo "Inventory file generated at ../ansible/inventory.ini"
EOT
  }

  triggers = {
    public_ip = join(",", module.vm[*].vm_public_ip)
  }

  depends_on = [module.vm]
}
