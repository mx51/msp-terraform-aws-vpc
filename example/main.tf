module "vpc" {
  source = "../"

  vpc_name       = "cmdlab-tf"
  vpc_cidr_block = "10.111.0.0/16"

  availability_zones = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]

  vpc_enable_dns_support   = true
  vpc_enable_dns_hostnames = true

  enable_virtual_private_gateway = true
  enable_nat_gateway = true
  enable_per_az_nat_gateway = true

  nacl_public_custom = {
    allow_https = {
      rule_number = 1000
      egress = false
      protocol = 6
      rule_action = "allow"
      cidr_block = "0.0.0.0/0"
      from_port = 443
      to_port = 443
    }
    allow_http = {
      rule_number = 1001
      egress = false
      protocol = 6
      rule_action = "allow"
      cidr_block = "0.0.0.0/0"
      from_port = 80
      to_port = 80
    }
    allow_ssh = {
      rule_number = 1002
      egress = false
      protocol = 6
      rule_action = "allow"
      cidr_block = "0.0.0.0/0"
      from_port = 22
      to_port = 22
    }
  }

  tags = {
    Owner      = "Foo"
    Department = "Bar"
  }
}
