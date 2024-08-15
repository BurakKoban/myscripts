kubectl get nodes

kubectl get pods

kubectl run nginx --image=nginx

kubectl run nginx --image=nginx --dry-run=client -o yaml > pod-definition.yaml # Generate POD Manifest YAML file (-o yaml). Don't create it(--dry-run)

kubectl describe pod nginx

kubectl describe pod netshoot -n bcaa-ops > pod-description.yaml

kubectl run my-nginx --image=nginx

kubectl get pod -o yaml

kubectl get pod nginx -o yaml > pod-definition.yaml

kubectl apply -f pod-definition.yaml

kubectl create -f pod-definition.yaml

kubectl delete pod webapp

kubectl edit pod nginx



