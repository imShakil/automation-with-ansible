
module "vpc" {
  source = "git::https://github.com/imShakil/tfmodules.git//aws/vpc"

  prefix     = var.prefix
  cidr_block = var.cidr_block
}

module "rds" {
  source = "git::https://github.com/imShakil/tfmodules.git//aws/rds"

  rds_name           = var.rds_name
  rds_admin          = var.rds_admin
  rds_admin_password = var.rds_admin_password
  private_subnets    = module.vpc.vpc_attribute.private_subnet_ids
  security_group_ids = [module.vpc.vpc_attribute.security_group_id]
}

data "aws_ami" "ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  ssh_key_pair = {
    ssh_username = "${var.prefix}-ssh-key"
    ssh_key_path = var.ssh_key_path
  }
}

# resource "aws_vpc_security_group_ingress_rule" "allow_internal" {
#   security_group_id = module.vpc.vpc_attribute.security_group_id
#   from_port         = -1
#   to_port = -1
#   ip_protocol = "-1"
#   cidr_ipv4 = var.cidr_block
# }

module "instance" {
  source = "git::https://github.com/imShakil/tfmodules.git//aws/instance"

  ami_id                 = data.aws_ami.ami.id
  subnet_id              = module.vpc.vpc_attribute.public_subnet_ids[0]
  vpc_security_group_ids = [module.vpc.vpc_attribute.security_group_id]
  ssh_key_pair           = local.ssh_key_pair
  instance_number        = 2
  prefix                 = var.prefix

}

resource "local_file" "inventory" {
  content = <<EOT

[frontend]
${module.instance.instance_attribute.public_ip[0]}

[backend]
${module.instance.instance_attribute.public_ip[1]}

[all:vars]
ansible_user='ubuntu'
ansible_ssh_private_key_file='~/.ssh/id_rsa'
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOT

  filename = "../ansible/inventory.ini"

  depends_on = [
    module.instance
  ]

}

resource "local_file" "rds_info" {
  content = <<EOT
rds_endpoint: "${split(":", module.rds.rds_info.endpoint)[0]}"
rds_port: "${split(":", module.rds.rds_info.endpoint)[1]}"
rds_name: "${var.rds_name}"
rds_admin: "${var.rds_admin}"
rds_admin_password: "${var.rds_admin_password}"
EOT

  filename = "../ansible/group_vars/rds_info.yml"
  depends_on = [module.rds]
}
