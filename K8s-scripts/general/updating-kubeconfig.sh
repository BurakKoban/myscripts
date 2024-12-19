aws eks --region us-west-2 update-kubeconfig --name burak-test --profile automation

kubectl config use-context bcaa-devops-eks

kubectl cluster-info

kubectl api-resources