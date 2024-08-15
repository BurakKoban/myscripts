default_profile  = "ani_preprod"
domain_name      = "ani-preprod.bcaa.bc.ca"
vpc_cidr         = "10.18.0.0/21"
private_subnets  = ["10.18.0.0/24", "10.18.1.0/24", "10.18.2.0/24"]
intra_subnets    = ["10.18.3.0/24", "10.18.4.0/24", "10.18.5.0/24"]
public_subnets   = ["10.18.6.0/26", "10.18.6.64/26", "10.18.6.128/26"]

vpc_interconnection = true
tgw_across_region   = true
zone_enabled        = true
acm_enabled         = true