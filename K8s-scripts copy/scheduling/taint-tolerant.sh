# How to taint a node

kubectl taint nodes node-name key=value:taint-effect

kubectl taint nodes node1 app=blue:NoSchedule/PreferNoSchedule/NoExecute

kubectl taint nodes node1 app=blue:NoSchedule

# to remove the taint

kubectl taint node controlplane node-role.kubernetes.io/master:NoSchedule-

# To add tolarations for a pod

kubectl run myapp-pod --image=nginx --dry-run=client -o yaml > nginx.yaml

# Then add tolarations "for app=blue taint on the nodes" into the yaml file

apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
spec:
  containers:
  - image: nginx
    name: nginx-container

  tolerations:
  - key: "app"
    operator: "Equal"
    value: "blue"
    effect: "NoSchedule"