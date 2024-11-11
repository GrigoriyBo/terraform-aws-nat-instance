resource "aws_route" "outbound_nat_route" {
  for_each                    = toset(var.private_subnet_route_table_ids)
  route_table_id              = each.value
  destination_cidr_block      = "0.0.0.0/0"
  network_interface_id        = module.instance.primary_network_interface_id

  depends_on = [module.instance]
}
