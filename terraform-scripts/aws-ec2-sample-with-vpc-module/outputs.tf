output "ec2_nstance_id" {

    value =  aws_instance.sample_instance.id

}

output "private_ip" {
  value       = aws_instance.sample_instance.private_ip
  description = "The private IP of the web server"
}

/*
output "vpc_id_from_vpc_module" {
 sensitive = false
 value = data.terraform_remote_state.vpc_module.vpc_id
}
*/