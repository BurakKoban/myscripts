default_profile  = "ani_prod"
region           = "ca-central-1"
domain_name      = "ani-prod.bcaa.bc.ca"
vpc_cidr         = "10.18.8.0/21"
private_subnets  = ["10.18.8.0/24", "10.18.9.0/24", "10.18.10.0/24"]
intra_subnets    = ["10.18.11.0/24", "10.18.12.0/24", "10.18.13.0/24"]
public_subnets   = ["10.18.14.0/26", "10.18.14.64/26", "10.18.14.128/26"]

vpc_interconnection = true
tgw_across_region   = true
tgw_inspect_all     = false
zone_enabled        = true
acm_enabled         = true   // need to define the zone_id if 'zone_enabled = false'