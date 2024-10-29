module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.24.3"

  # EKS CONTROL PLANE VARIABLES
  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version

  # EKS Cluster VPC and Subnet mandatory config
  vpc_id                   = local.vpc_id
  subnet_ids               = local.private_subnets
  control_plane_subnet_ids = local.intra_subnets
  
  # Lock down EKS API public access 
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  cluster_endpoint_public_access_cidrs = [

    # BCAA Public network
    "192.197.50.196/32",
    "44.228.230.226/32",
    "44.232.101.137/32",
    "52.60.235.50/32",
    "72.142.53.234/32"

  ]

  # External encryption key
  create_kms_key = false
  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = module.eks_kms_key.key_arn
  }


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
    ebs_optimized           = true
    disable_api_termination = false
    enable_monitoring       = true
    force_update_version    = false
    instance_types = ["t3a.medium", "t3.medium", "t2.medium"] 

     metadata_options = {
      http_endpoint               = "enabled"
      http_tokens                 = "required"
      http_put_response_hop_limit = 1
      instance_metadata_tags      = "disabled"
    }
 
      block_device_mappings = {
      xvda = {
        device_name = "/dev/xvda"
        ebs = {
          volume_size           = 30
          volume_type           = "gp3"
          #encrypted             = true
          #kms_key_id            = module.ebs_kms_key.key_arn
          delete_on_termination = true
        }
      }
    }
    
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
      additional                         = aws_iam_policy.node_additional.arn
    }
    
  }

  eks_managed_node_groups = {
    burak_test_nodes = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      name            = "main-test-nodes"
      use_name_prefix = true
      description     = "Default managed node group launch template"
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3a.medium", "t3.medium", "t2.medium"] 
      subnet_ids      = local.private_subnets

      min_size     = 1
      max_size     = 3
      desired_size = 2
    
   
      
      
      update_config = {
        max_unavailable_percentage = 33 # or set `max_unavailable`
      }

      taints = {
        # This Taint aims to keep just EKS Addons and Karpenter running on this MNG
        # The pods that do not tolerate this taint should run on nodes created by Karpenter
        addons = {
          key    = "mainworkload"
          value  = "true"
          effect = "NO_SCHEDULE"
        },
      }
      tags = local.tags

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

}

################################################################################
# Supporting Resources
################################################################################

resource "aws_iam_policy" "node_additional" {
  name        = "${local.name}-additional"
  description = "Example usage of node additional policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  tags = local.tags
}

module "eks_kms_key" {
  source  = "terraform-aws-modules/kms/aws"
  version = "~> 3.1.0"

  description = "${local.name} cluster encryption key"

  deletion_window_in_days = 10
  enable_key_rotation     = true
  is_enabled              = true

  # Policy
  enable_default_policy = true
  key_owners            = [data.aws_caller_identity.current.arn]

  # Aliases
  aliases = ["bcaa/${local.name}/cluster"]

  tags =  local.tags
}


