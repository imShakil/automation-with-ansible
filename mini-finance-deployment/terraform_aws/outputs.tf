output "vpc_info" {
  value = module.vpc.vpc_attribute
}

output "ec2_info" {
  value = module.instance.instance_attribute

}
