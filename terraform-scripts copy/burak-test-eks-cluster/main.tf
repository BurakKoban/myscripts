module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = module.label.id
  cluster_version = var.cluster_version

  # Lock down EKS API public access 
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false

  # External encryption key
  create_kms_key = false
  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = module.eks_kms_key.key_arn
  }

  # Extend cluster security group rules
  cluster_security_group_name = "${local.cluster_name}-cluster"
  cluster_security_group_additional_rules = {

    ingress_nodes_ephemeral_ports_tcp = {
      description                = "Nodes on ephemeral ports"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "ingress"
      source_node_security_group = true
    }

    ingress_source_security_group_id = {
      description              = "Ingress from another computed security group for port 443"
      protocol                 = "tcp"
      from_port                = 443
      to_port                  = 443
      type                     = "ingress"
      source_security_group_id = aws_security_group.additional.id
    }

    ingress_source_security_group_id = {
      description              = "SSH access for port 22"
      protocol                 = "tcp"
      from_port                = 22
      to_port                  = 22
      type                     = "ingress"
      source_security_group_id = aws_security_group.additional.id
    }

    ingress_source_security_group_id = {
      description              = "Allows inbound NFS traffic from another computed security group"
      protocol                 = "tcp"
      from_port                = 2049
      to_port                  = 2049
      type                     = "ingress"
      source_security_group_id = aws_security_group.additional.id
    }

    ingress_source_security_group_id = {
      description              = "Allows AWS internal network"
      protocol                 = "-1"
      from_port                = 0
      to_port                  = 0
      type                     = "ingress"
      cidr_blocks              = ["10.0.0.0/8"]
    }

    egress_nodes_ephemeral_ports_tcp = {
      description                = "Allow outbound traffic"
      protocol                   = "-1"
      from_port                  = 0
      to_port                    = 0
      type                       = "egress"
      #source_node_security_group = true
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  cluster_security_group_tags = {
    Name = "${local.cluster_name}-cluster"
  }

  # Extend node-to-node security group rules
  node_security_group_name = "${local.cluster_name}-node"
  node_security_group_additional_rules = {

    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }

    ingress_source_security_group_id = {
      description              = "Ingress from another computed security group two"
      protocol                 = "tcp"
      from_port                = 443
      to_port                  = 443
      type                     = "ingress"
      source_security_group_id = aws_security_group.additional.id
    }

#    ingress_source_security_group_id = {
#      description              = "Cluster API to Node group for Karpenter webhook"
#      protocol                 = "tcp"
#      from_port                = 8443
#      to_port                  = 8443
#      type                     = "ingress"
#      source_security_group_id = aws_security_group.additional.id
#    }
#
#    ingress_source_security_group_id = {
#      description              = "Cluster API to Node group for ESO webhook"
#      protocol                 = "tcp"
#      from_port                = 9443
#      to_port                  = 9443
#      type                     = "ingress"
#      source_security_group_id = aws_security_group.additional.id
#    }
#
#    ingress_source_security_group_id = {
#      description              = "Allows inbound NFS traffic"
#      protocol                 = "tcp"
#      from_port                = 2049
#      to_port                  = 2049
#      type                     = "ingress"
#      source_security_group_id = aws_security_group.additional.id
#    }

    ingress_source_security_group_id = {
      description              = "Allows AWS internal network"
      protocol                 = "-1"
      from_port                = 0
      to_port                  = 0
      type                     = "ingress"
      cidr_blocks              = ["10.0.0.0/8"]
    }

    egress_all = {
      description = "Node all egress"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      #cidr_blocks = [local.cidr_blocks]
      cidr_blocks = ["0.0.0.0/0"]
    }
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

  vpc_id                   = local.vpc_id
  subnet_ids               = local.private_subnets
  control_plane_subnet_ids = local.public_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    
    ebs_optimized           = true
    disable_api_termination = false
    enable_monitoring       = true
    force_update_version    = false
    instance_types = ["t3a.large", "t3.large"]

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
          volume_size           = 50
          volume_type           = "gp3"
        #  encrypted             = true
        #  kms_key_id            = var.ebs_kms_key
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
      #AmazonEKSWorkerNodePolicy          = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
      #AmazonEKS_CNI_Policy               = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      AmazonEKSVPCResourceController     = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
      additional                         = aws_iam_policy.node_additional.arn
    }

  }

  eks_managed_node_groups = {
    default_burak_test_mng = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      # ami_type        = data.aws_ami.eks.image_id
      name            = "default-burak-test-mng"
      use_name_prefix = true
      description     = "Default managed node group launch template"
      capacity_type   = "SPOT"
      instance_types = ["t3a.large", "t3.large"]
      subnet_ids      = local.private_subnets

      min_size     = 1
      max_size     = 5
      desired_size = 2

      update_config = {
        max_unavailable_percentage = 33 # or set `max_unavailable`
      }

      taints = {
        # This Taint aims to keep just EKS Addons and Karpenter running on this MNG
        # The pods that do not tolerate this taint should run on nodes created by Karpenter
        addons = {
          key    = "CriticalAddonsOnly"
          value  = "true"
          effect = "NO_SCHEDULE"
        },
      }

      labels = {
        GithubRepo = "terraform-aws-eks"
        GithubOrg  = "terraform-aws-modules"
      }

      tags = {
        ExtraTag = "EKS managed node group complete example"
      }
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  authentication_mode                      = "API_AND_CONFIG_MAP"
  enable_cluster_creator_admin_permissions = true

  access_entries = {
    # One access entry with a policy associated
    EKSAccess = {
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

  tags = merge({
    GithubRepo = "terraform-aws-kms"
    GithubOrg  = "terraform-aws-modules"
  }, local.tags)
}

resource "aws_security_group" "additional" {
  name_prefix = "${local.cluster_name}-additional"
  vpc_id      = local.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = local.cidr_blocks
  }

  tags = merge({
    Name = "${local.cluster_name}-additional"
  }, local.tags)
}