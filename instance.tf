resource "aws_eip_association" "this" {
  count         = length(var.public_subnets)
  instance_id   = aws_instance.nat[count.index].id
  allocation_id = aws_eip.this[count.index].id
}

resource "aws_instance" "nat" {
  count                       = length(var.public_subnets)
  ami                         = data.aws_ami.ami.id
  instance_type               = var.instance_type
  source_dest_check           = false
  iam_instance_profile        = aws_iam_instance_profile.nat_profile.id
  key_name                    = var.key_name
  subnet_id                   = element(var.public_subnets, count.index)
  vpc_security_group_ids      = [aws_security_group.this.id]
  user_data_replace_on_change = var.user_data_replace_on_change
  user_data = templatefile("${path.module}/templates/nat-user-data.conf.tmpl", {
    name          = var.name
    mysubnet      = element(var.private_subnets, count.index)
    vpc_cidr      = var.vpc_cidr_block
    awsnycast_url = var.awsnycast_url
  })

  lifecycle {
    ignore_changes = [
      associate_public_ip_address,
      public_dns,
      public_ip
    ]
  }

  tags       = local.tags
  depends_on = [aws_security_group.this]
}
