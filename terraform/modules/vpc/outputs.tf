output "vpc_arn" {
  value = aws_vpc.main.arn
}

output "vpc_security_group_ids" {
  value = [aws_security_group.tls_ssh.id]
}

output "subnet_server_id_a" {
  value = aws_subnet.main_a.id
}

output "gateway" {
  value = aws_internet_gateway.gw
}
