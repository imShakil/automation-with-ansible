output "instance_attribute" {
  value = {
    id           = aws_instance.epkbk_ec2.id
    public_ip    = aws_instance.epkbk_ec2.public_ip
    private_ip   = aws_instance.epkbk_ec2.private_ip
    public_dns   = aws_instance.epkbk_ec2.public_dns
    private_dns  = aws_instance.epkbk_ec2.private_dns
    ssh_key_name = aws_key_pair.ec2_ssh_key.key_name
  }

}
