kubectl get roles

kubectl get rolebindings

kubectl describe role developer

kubectl describe rolebinding developer

# To check access

kubectl auth can-i create nodes

# To check access for specific user

kubectl auth can-i create deployments --as burak -namespace test


