variable "name" {}

variable "instance_type" {
  description = "NAT Instances type"
  default     = "t3.nano"
  type        = string
}

variable "vpc_id" {
  description = "NAT Instances VPC ID"
  type        = string
}

variable "vpc_cidr_block" {
  description = "NAT Instances VPC Cidr"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets for NAT routing"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnets for NAT routing"
  type        = list(string)
}

variable "awsnycast_url" {
  default = "https://github.com/bobtfish/AWSnycast/releases/download/v0.1.5/awsnycast-0.1.5-425.x86_64.rpm"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "route_table_identifier" {
  description = "Indentifier used by AWSnycast route table regexp. If you are using the terraform-aws-vpc module you will need to set its value to \"private\""
  default     = "-private"
}

variable "user_data_replace_on_change" {
  type        = bool
  default     = true
  description = "Destroy instance when update userdata"
}

locals {
  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags
  )
}

variable "key_name" {
    description = "EC2 SSH key pair name"
    type        = string
}

variable "zerotier_network_id" {
    description = "ZeroTier Network ID"
    type        = string
}
