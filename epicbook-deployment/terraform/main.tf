
module "vpc" {
  source     = "./modules/vpc"
  prefix     = var.prefix
  cidr_block = var.cidr_block

}


module "instance" {
  source                = "./modules/instance"
  vpc_security_group_id = module.vpc.vpc_attribute.security_group_id
  subnet_id             = module.vpc.vpc_attribute.public_subnet_id
  ami_id                = var.ami_id
  prefix                = var.prefix
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
ansible_user="ec2-user"
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
