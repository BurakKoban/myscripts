kubectl explain replicasets

kubectl create -f replicaset-definition.yaml

kubectl get replicaset

kubectl get rs

kubectl describe replicaset myapp-replicaset

kubectl edit rs myapp-replicaset

kubectl delete replicaset myapp-replicaset

kubectl replace -f replicaset-definition.yaml

kubectl scale --replicas=6 -f replicaset-definition.yaml

kubectl scale --replicas=6 replicaset myapp-replicaset
