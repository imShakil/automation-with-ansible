variable "prefix" {
  default = "minifinacne"
}

variable "region" {
  default = "southeastasia"
}

variable "vnet_cidr" {
  default = "10.0.0.0/16"
}

variable "vnet_cidr_public_sub1" {
  default = "10.0.1.0/24"
}

variable "vnet_cidr_private_sub1" {
  default = "10.0.16.0/24"
}

variable "ssh_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "vm_admin" {
  default = "imshakil"
}
