resource "aws_vpc" "myVPC" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.prefix}-vpc"
    Environment = terraform.workspace
  }

}

resource "aws_internet_gateway" "myIGW" {
  vpc_id = aws_vpc.myVPC.id

  tags = {
    Name        = "${var.prefix}-igw"
    Environment = terraform.workspace
  }

}

resource "aws_route_table" "myPublicRT" {
  vpc_id = aws_vpc.myVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myIGW.id
  }

  tags = {
    Name        = "${var.prefix}-publiRT"
    Environment = terraform.workspace
  }
}

resource "aws_security_group" "mySG" {
  vpc_id      = aws_vpc.myVPC.id
  name        = "${var.prefix}-sg"
  description = "Security group for ${var.prefix}-vpc"

  tags = {
    Name        = "${var.prefix}-sg"
    Environment = terraform.workspace
  }

}

resource "aws_vpc_security_group_ingress_rule" "allows_ssh" {
  security_group_id = aws_security_group.mySG.id
  description       = "Allows SSH"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"

}

resource "aws_vpc_security_group_ingress_rule" "allows_http" {
  security_group_id = aws_security_group.mySG.id
  description       = "Allows HTTP"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"

}

resource "aws_vpc_security_group_ingress_rule" "allows_https" {
  security_group_id = aws_security_group.mySG.id
  description       = "Allows HTTPS"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"

}

resource "aws_vpc_security_group_egress_rule" "allows_all" {
  security_group_id = aws_security_group.mySG.id
  description       = "Allows all"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.public_subnet
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.prefix}-public_subnet"
  }
}

resource "aws_route_table_association" "publicRTAssociate" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.myPublicRT.id
}
