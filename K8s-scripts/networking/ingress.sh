# You must deploy ingress controller

# GCE, NGINX, Contour, HAPROXY, Treafik, Istio

kubectl get ingress

kubectl create -f ingress.yaml

kubectl edit ingress nginx-ingress

kubectl delete ingress nginx-ingress