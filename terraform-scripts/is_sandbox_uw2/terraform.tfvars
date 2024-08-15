default_profile  = "sandbox"
domain_name      = "sandbox.bcaa.bc.ca"
vpc_cidr         = "10.26.12.0/22"
private_subnets  = ["10.26.12.0/25", "10.26.12.128/25", "10.26.13.0/25"]
# intra_subnets    = ["10.26.15.0/25", "10.26.15.128/25", "10.26.15.128/25"]
public_subnets   = ["10.26.13.128/25", "10.26.14.0/25", "10.26.14.128/25"]

vpc_interconnection = true
tgw_across_region   = true
tgw_inspect_all     = false
zone_enabled        = true
acm_enabled         = true