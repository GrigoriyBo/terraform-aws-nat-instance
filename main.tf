data "aws_ami" "ubuntu-linux-2204" {
  most_recent = true
  owners      = [var.ami_owner]

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }

  filter {
    name   = "virtualization-type"
    values = [var.virtualization_type]
  }
}

module "instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "= 5.7.1"

  name = var.name

  ami                     = data.aws_ami.ubuntu-linux-2204.id
  ignore_ami_changes      = true
  instance_type           = var.instance_type
  key_name                = var.ssh_key_name
  monitoring              = false
  disable_api_termination = true
  availability_zone       = var.availability_zone
  subnet_id               = var.subnet_id
  create_eip              = true
  eip_tags                = var.tags
  private_ip              = var.private_ip
  vpc_security_group_ids  = var.vpc_security_group_ids

  root_block_device = [
    {
      encrypted   = false
      volume_type = "gp2"
      volume_size = 8
    }
  ]

  user_data = <<-EOL
                sudo apt-get update
                sudo DEBIAN_FRONTEND=noninteractive apt-get install -y iptables-persistent
                sudo sysctl -w net.ipv4.ip_forward=1
                echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
                sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
                sudo iptables -F FORWARD
                sudo netfilter-persistent save
  EOL

  tags = var.tags
}
