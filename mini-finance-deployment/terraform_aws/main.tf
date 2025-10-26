
module "vpc" {
  source = "git::https://github.com/imShakil/automation-with-ansible.git//epicbook-deployment/terraform/modules/vpc"
  prefix = var.prefix
  cidr_block = var.cidr_block
  public_subnet = var.public_subnet_cidr
}

module "instance" {
  source = "git::https://github.com/imShakil/automation-with-ansible.git//epicbook-deployment/terraform/modules/instance"
  prefix = var.prefix
  subnet_id = module.vpc.vpc_attribute.public_subnet_id
  vpc_security_group_id = module.vpc.vpc_attribute.security_group_id
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  ssh_key_pair          = var.ssh_key_pair

}

resource "null_resource" "generate_inventory" {
  provisioner "local-exec" {
    command = <<EOT
#!/bin/bash
set -e

cat > ../ansible/inventory.ini <<EOF
[app]
${module.instance.instance_attribute.public_ip}

[all:vars]
ansible_user="ubuntu"
ansible_ssh_private_key_file=~/.ssh/id_rsa
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
EOF

echo "Inventory file generated at ../ansible/inventory.ini"
EOT
  }

  triggers = {
    public_ip = module.instance.instance_attribute.public_ip
  }

  depends_on = [module.instance]
}
