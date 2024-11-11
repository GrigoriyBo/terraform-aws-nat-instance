
output "id" {
  description = "The Instance ID of the NAT EC2 instance"
  value       = module.instance.id
}

output "public_ip" {
  description = "The public IP address of the NAT EC2 instance"
  value       = module.instance.public_ip
}

output "private_ip" {
  description = "The private IP address of the NAT EC2 instance"
  value       = module.instance.private_ip
}

output "network_interface_id" {
  description = "The network interface ID of the NAT EC2 instance"
  value       = module.instance.primary_network_interface_id
}

output "instance_availability_zone" {
  description = "The availability zone of the NAT EC2 instance"
  value       = module.instance.availability_zone
}

output "instance_public_dns" {
  description = "The public DNS name of the NAT EC2 instance"
  value       = module.instance.public_dns
}

output "nat_instance_private_dns" {
  description = "The private DNS name of the NAT EC2 instance"
  value       = module.instance.private_dns
}
