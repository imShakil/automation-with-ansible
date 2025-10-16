output "vnetId" {
  value = module.network.vn_id
}

output "vnet_public_subnet" {
  value = module.network.public_subnet1_id
}

output "vnet_private_subnet" {
  value = module.network.private_subnet1_id
}

output "public_ip" {
  value = module.vm[*].vm_public_ip
}
