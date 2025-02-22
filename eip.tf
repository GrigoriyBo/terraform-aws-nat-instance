resource "aws_eip" "this" {
  count = length(var.public_subnets)
  vpc   = true
}
