output "vpc_info" {
  value = module.vpc.vpc_attribute
}

output "rds_info" {
  value = module.rds.rds_info
}

output "ec2_info" {
  value = module.instance.instance_attribute
}
