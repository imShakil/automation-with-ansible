variable "region" {
  default = "ap-southeast-1"
}

variable "prefix" {
  default = "bkReview"
}

variable "cidr_block" {
  default = "10.10.0.0/16"
}

variable "rds_name" {}
variable "rds_admin" {}
variable "rds_admin_password" {}

variable "ssh_key_path" {
  default = "~/.ssh/id_rsa.pub"
}
