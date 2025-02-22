variable "name" {
  description = "The name of the NAT instance"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type for the NAT instance"
  type        = string
  default     = "t3.micro"
}

variable "ssh_key_name" {
  description = "The name of the SSH key pair to access the NAT instance"
  type        = string
  default     = "main"
}

variable "availability_zone" {
  description = "The AWS availability zone where the NAT instance will be deployed"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "private_ip" {
  description = "A list of private IP addresses to assign to the NAT instance's network interface"
  type        = string
}

# Optional: Variables for AMI customization

variable "ami_owner" {
  description = "The AWS account ID of the AMI owner"
  type        = string
  default     = "099720109477"  # Canonical's AWS account ID for Ubuntu
}

variable "ami_name_filter" {
  description = "The name filter for selecting the AMI"
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

variable "virtualization_type" {
  description = "The virtualization type for the AMI"
  type        = string
  default     = "hvm"
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}

variable "private_subnet_route_table_ids" {
    description = "A list of private subnet route table IDs to associate with"
    type        = list(string)
    default     = null
}

variable "subnet_id" {
    description = "The subnet ID to associate with the network interface"
    type        = string
}

variable "additional_user_data" {
  description = "Additional shell commands to execute in user_data"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the NAT instance"
  type        = list(string)
  default     = []
}
