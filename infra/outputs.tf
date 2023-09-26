output "out_vpc_id" {
  value = aws_vpc.vpc.id
}

output "out_subnet_public1_id" {
  value = aws_subnet.subnet_public1.id
}

output "out_subnet_private1_id" {
  value = aws_subnet.subnet_private1.id
}

output "out_igw_id" {
  value = aws_internet_gateway.internet_gateway.id
}

output "out_route_table_id" {
  value = aws_route_table.vpc_route_table.id
}

output "out_ec2_instance_public_ip" {
  value = aws_instance.app_server.public_ip
}

output "out_ec2_instance_access" {
  value = "http://${aws_instance.app_server.public_ip}"
}