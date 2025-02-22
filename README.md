
# Terraform NAT Instance Module

This Terraform module creates a NAT instance using the `terraform-aws-modules/ec2-instance/aws` module. It is configured with Ubuntu 22.04, and comes pre-configured with NAT settings and optional user-defined customizations.

Additionally, this module configures routes for private subnets to use the NAT instance for outbound internet access.

## Requirements

- [Terraform](https://www.terraform.io/downloads.html) >= 0.12
- AWS account credentials with permissions to create EC2 instances, EIP, and manage network settings

## Usage

```hcl
module "nat_instance" {
  source  = "./path-to-this-module"

  name                    = "nat-instance"
  instance_type           = "t3.micro"
  ssh_key_name            = "main"
  availability_zone       = "us-east-1a"
  subnet_id               = "subnet-0123456789abcdef"
  private_ip              = "10.0.1.10"
  vpc_security_group_ids  = ["sg-0123456789abcdef0"]
  tags                    = {
    Environment = "production"
    Name        = "nat-instance"
  }

  # Optional customizations
  ami_owner            = "099720109477"
  ami_name_filter      = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
  virtualization_type  = "hvm"
  additional_user_data = ["echo 'Additional setup commands here'"]
  private_subnet_route_table_ids = ["rtb-0123456789abcdef0", "rtb-0fedcba9876543210"]
}
```

## Variables

| Variable                        | Description                                                       | Type           | Default                                          |
|---------------------------------|-------------------------------------------------------------------|----------------|--------------------------------------------------|
| `name`                          | The name of the NAT instance                                      | `string`       | N/A                                              |
| `instance_type`                 | EC2 instance type for the NAT instance                            | `string`       | `t3.micro`                                       |
| `ssh_key_name`                  | SSH key pair name for instance access                             | `string`       | `"main"`                                         |
| `availability_zone`             | AWS availability zone for deployment                              | `string`       | N/A                                              |
| `subnet_id`                     | Subnet ID for the network interface                               | `string`       | N/A                                              |
| `private_ip`                    | Private IP address for the instance                               | `string`       | N/A                                              |
| `vpc_security_group_ids`        | List of security group IDs for the instance                       | `list(string)` | `null`                                           |
| `tags`                          | Tags to assign to all resources                                   | `map(string)`  | `{}`                                             |
| `ami_owner`                     | AWS account ID of the AMI owner                                   | `string`       | `"099720109477"` (Canonical's ID for Ubuntu)     |
| `ami_name_filter`               | Name filter to select the AMI                                     | `string`       | `"ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"` |
| `virtualization_type`           | Virtualization type for the AMI                                   | `string`       | `"hvm"`                                          |
| `private_subnet_route_table_ids`| List of route table IDs for private subnets                       | `list(string)` | `null`                                           |
| `additional_user_data`          | Additional shell commands in `user_data`                          | `list(string)` | `[]`                                             |

## Resources

- **aws_route.outbound_nat_route**: This resource creates a route in each specified private subnet route table to allow outbound internet access through the NAT instance.

## Outputs

The module does not define specific outputs. If you wish to retrieve the instance's IP, ID, or other attributes, consider adding outputs as needed.

## EC2 NAT Instance Configuration

The `user_data` script provided in this module configures the instance as a NAT by setting up IP forwarding and `iptables` rules:

- Enables IP forwarding
- Configures `iptables` for NAT
- Saves the `iptables` configuration for persistence across reboots

You can extend the `user_data` script with additional commands by using the `additional_user_data` variable.

## Example User Data Configuration

The `user_data` script initializes basic NAT functionality. Additional commands can be appended via the `additional_user_data` variable, for example:

```hcl
additional_user_data = [
  "echo 'Starting additional configuration...'",
  "sudo apt-get install -y your-package-name"
]
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

