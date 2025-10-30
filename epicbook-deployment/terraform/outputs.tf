output "vpc_info" {
  value = module.vpc.vpc_attribute
}

output "rds_info" {
  value = module.db.rds_info
}

output "instance_attribute" {
  value = module.instance.instance_attribute
}
