variable "prefix" {
  default = "my"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet" {
  type    = string
  default = "10.0.0.0/24"
}
