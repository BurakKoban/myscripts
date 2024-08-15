
data "terraform_remote_state" "inf_eks" {
 backend   = "s3"

 config = {
   profile              = "automation_tf"
   region               = "us-west-2"
   bucket               = "bcaa-automation-terraform-state"
   key                  = "single-account/automation/eks-projects/bcaa-inf-eks/terraform.tfstate"
   encrypt              = true    #AES-256 encryption
 }
}

