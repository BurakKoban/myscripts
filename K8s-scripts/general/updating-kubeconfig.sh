aws eks --region us-west-2 update-kubeconfig --name bcaa-devops-eks --profile default

kubectl config use-context bcaa-devops-eks

kubectl cluster-info

kubectl api-resources