aws eks --region ca-central-1 update-kubeconfig --name ani-prd-ca-eks --profile ani_prod

kubectl config use-context bcaa-devops-eks

kubectl cluster-info

kubectl api-resources