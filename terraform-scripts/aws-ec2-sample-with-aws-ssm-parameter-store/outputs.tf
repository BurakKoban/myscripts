output "vpc_id" {
 sensitive = true
 value = data.aws_ssm_parameter.vpc_id.value
}

output "subnet_id_list1" {
 sensitive = true
 value = data.aws_ssm_parameter.subnet_id_list.value
}

output "subnet_id_list2" {
 #sensitive = true
 value = nonsensitive(split(",",data.aws_ssm_parameter.subnet_id_list.value)[0])
}