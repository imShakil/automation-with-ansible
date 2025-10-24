variable "prefix" {
  default = "my"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_security_group_id" {}
variable "subnet_id" {}
variable "ami_id" {}
variable "ssh_key_pair" {}

variable "user_data_path" {
  default = null
}

variable "tags" {
  default = null
}
