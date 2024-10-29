module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.24.3"

  # EKS CONTROL PLANE VARIABLES
  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version

  # EKS Cluster VPC and Subnet mandatory config
  vpc_id                   = "vpc-0b69ad5898b70c416"
  subnet_ids               = ["subnet-0d3a3aa7c364b475b","subnet-0ceac56e566cb14ea"]
  control_plane_subnet_ids = ["subnet-0d3a3aa7c364b475b","subnet-0ceac56e566cb14ea"]
  
  # Lock down EKS API public access 
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
#  cluster_endpoint_public_access_cidrs = [
#
#    # BCAA Public network
#    "192.197.50.196/32",
#    "44.228.230.226/32",
#    "44.232.101.137/32",
#    "52.60.235.50/32",
#    "72.142.53.234/32",
#
#  ]


  # EKS most basic Add-ons
  cluster_addons = {
    coredns = {
      most_recent = true
      timeouts = {
        create = "25m"
        delete = "10m"
      }
    }
    kube-proxy = {
      most_recent = true
    }
    eks-pod-identity-agent = {
      resolve_conflicts = "OVERWRITE"
      most_recent       = true
    }
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
      most_recent       = true
    }
  }


  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3a.medium", "t3.medium", "t2.medium"] 
  }

  eks_managed_node_groups = {
    test_mng = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3a.medium", "t3.medium", "t2.medium"] 

      min_size     = 1
      max_size     = 3
      desired_size = 2
    
    enable_irsa              = true
      create_iam_role          = true
      iam_role_name            = "${local.cluster_name}-node-group-role"
      iam_role_use_name_prefix = true
      iam_role_description     = "${local.cluster_name}-managed node group"
      iam_role_tags = {
        Purpose = "Protector of the kubelet"
      }

      iam_role_additional_policies = {
        AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
        AmazonSSMManagedInstanceCore       = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
        CloudWatchAgentServerPolicy        = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
        AmazonEKSVPCResourceController     = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
      
      }
    
    }
  }

 
  # Cluster access entry
  # To add the current caller identity as an administrator
  authentication_mode                      = "API_AND_CONFIG_MAP"
  enable_cluster_creator_admin_permissions = true

  access_entries = {
    # One access entry with a policy associated
    EKSaccess = {
      kubernetes_groups = []
      principal_arn     = "arn:aws:iam::200934923951:role/aws-reserved/sso.amazonaws.com/us-west-2/AWSReservedSSO_AWSAdministratorAccess_a50f0feca29f9b93"

      policy_associations = {
        example = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type       = "cluster"
          }
        }
      }
    }
  }

  tags = local.tags
}


