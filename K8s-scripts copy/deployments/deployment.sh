kubectl get all

kubectl create deployment --image=nginx nginx --dry-run -o yaml # Generate Deployment YAML file (-o yaml). Don't create it(--dry-run)

kubectl create deployment nginx --image=nginx--dry-run=client -o yaml > nginx-deployment.yaml # Another way to do this is to save the YAML definition to a file and modify

kubectl create deployment blue --image=nginx --replicas=3 # To create a deployment named blue with 3 replicas

kubectl edit deployment blue

kubectl create -f deployment-definition.yaml

kubectl get deployments

kubectl describe deploy front-end-deployment

kubectl delete deployment blue