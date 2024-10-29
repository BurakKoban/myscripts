kubectl create secret generic aws-sso-creds --from-literal=<key>=<value>

kubectl create secret generic app-secret --from-literal=DB_Host=mysql

kubectl get secrets

kubectl create secret generic app-secret --from-file=app_secret.properties

kubectl describe secrets app-secret -o yaml



