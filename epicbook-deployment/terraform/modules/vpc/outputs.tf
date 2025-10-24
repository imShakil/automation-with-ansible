output "vpc_attribute" {
  value = {
    vpc_id                   = aws_vpc.myVPC.id
    vpc_cidr_block           = aws_vpc.myVPC.cidr_block
    public_subnet_cidr_block = aws_subnet.public_subnet.cidr_block
    security_group_id        = aws_security_group.mySG.id
    public_subnet_id         = aws_subnet.public_subnet.id
  }
}
