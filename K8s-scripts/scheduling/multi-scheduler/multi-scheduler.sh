# To see the events to check which secheduler is used to place the pod

kubectl get events -o wide

# To see the logs

kubectl logs my-custom-scheduler --name-space=kube-system