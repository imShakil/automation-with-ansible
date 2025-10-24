output "epicbook_resources" {
  value = {
    vpc_id       = module.vpc.vpc_attribute.vpc_id
    instance_id  = module.instance.instance_attribute.id
    public_ip    = module.instance.instance_attribute.public_ip
    private_ip   = module.instance.instance_attribute.private_ip
    public_dns   = module.instance.instance_attribute.public_dns
    ssh_key_name = module.instance.instance_attribute.ssh_key_name
    ssh_username = "ec2-user"
  }
}
