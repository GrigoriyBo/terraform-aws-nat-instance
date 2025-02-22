output "nat_ips" {
  value = aws_instance.nat.*.public_ip
}

output "key_name" {
  value = aws_key_pair.this.key_name
}

output "private_key_pem" {
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}

output "public_key_pem" {
  value = tls_private_key.this.public_key_pem
}
