kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml # Create a Service named redis-service of type ClusterIP to expose pod redis on port 6379

# or 

kubectl create service clusterip redis --tcp=6379:6379 --dry-run=client -o yaml

kubectl expose pod nginx --port=80 --name nginx-service --type=NodePort --dry-run=client -o yaml # Create a Service named nginx of type NodePort to expose pod nginx's port 80 on port 30080 on the nodes

# or 

kubectl create service nodeport nginx --tcp=80:80 --node-port=30080 --dry-run=client -o yaml

kubectl create -f service-definition.yaml

kubectl describe svc kubernetes


