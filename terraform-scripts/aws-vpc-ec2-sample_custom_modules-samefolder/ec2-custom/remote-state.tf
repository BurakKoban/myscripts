data "terraform_remote_state" "vpc_module" {
 backend   = "s3"

 config = {
   profile              = "default"
   region               = "us-west-2"
   bucket               = "burak-terraform-state-testbucket"
   key                  = "single-account/ms_qa/remote-state-vpc/vpc-module/terraform.tfstate"
   encrypt              = true    #AES-256 encryption
 }
}

