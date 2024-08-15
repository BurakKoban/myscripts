# To check if there is scheduler or not

kubectl get pods -n kube-system

# To delete and recreate the pod

kubectl replace --force -f nginx.yaml

# To keep monitoring the process

kubectl get pods --watch

# To see how many nodes we have

kubectl get nodes
