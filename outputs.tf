output "nat_ips" {
  value = aws_instance.nat.*.public_ip
}

