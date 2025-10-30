variable "prefix" {
  default = "epkbk"
}

variable "ami_id" {
  default = "ami-0ffd8e96d1336b6ac"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet1_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet1_cidr" {
  default = "10.0.2.0/24"
}

variable "ssh_key_pair" {
  default = {
    ssh_username = "epkbk-key"
    ssh_key_path = "~/.ssh/id_rsa.pub"
  }
}


# RDS Information

variable "rds_name" {
  default = "epicbook"
}
variable "rds_admin" {
  default = "epicbook"
}

variable "rds_admin_password" {
  default = "epicbook"
}
