kubectl get pods -n kube-system

kubectl get pods --namespace=dev

kubectl create namespace dev

kubectl create -f namespace-dev.yaml

kubectl config set-context $(kubectl config current-context) --namespace=dev

kubectl get pods --all-namespaces

kubectl get pods -A

# service_name.namespace.service.domain
db-service.dev.svc.cluster.local
