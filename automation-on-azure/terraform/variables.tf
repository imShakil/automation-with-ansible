variable "prefix" {
  default = "adhoc"
}

variable "region" {
  default = "southeastasia"
  type    = string
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

variable "vm_count" {
  default = 2
  type    = number
}

variable "vm_size" {
  default = "Standard_B1s"
}

variable "vm_admin" {
  default = "imshakil"
}

variable "ssh_key_path" {
  default = "~/.ssh/id_rsa.pub"
}
