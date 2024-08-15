terraform {
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.9"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10"
    }
    
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.4.1"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    
    grafana = {
      source  = "grafana/grafana"
      version = ">= 1.13.3"
    }    
  }

  required_version = ">= 1.0.0"

  backend "s3" {
    profile              = "automation_tf"
    region               = "us-west-2"
    bucket               = "bcaa-automation-terraform-state"
    dynamodb_table       = "bcaa-automation-terraform-state-lock"
    key                  = "single-account/automation/eks-projects/neat-msqa-eks/terraform.tfstate"
    encrypt              = true     #AES-256 encryption
  }  
  
}


