# IRSA for VPC CNI 
module "vpc_cni_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.44.0"

  role_name_prefix      = "${module.eks.cluster_name}-vpc-cni-irsa-"
  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }

  tags = merge({
    GithubRepo = "terraform-aws-iam"
    GithubOrg  = "terraform-aws-modules"
  }, local.tags)
}
