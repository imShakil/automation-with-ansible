variable "prefix" {
  default = "mfin"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.0.0/24"
}

variable "ami_id" {
  default = "ami-0a2fc2446ff3412c3"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ssh_key_pair" {
  default = {
    ssh_username = "miniFinance"
    ssh_key_path = "~/.ssh/id_rsa.pub"
  }
}
