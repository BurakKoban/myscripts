kubectl rollout status deployment/myapp-deployment

kubectl rollout history deployment/myapp-deployment

# Deployment Strategy: 

# 1- Recreate Update

# 2- Rolling Update is the default one.

kubectl rollout undo deployment/myapp-deployment # To rollback

kubectl rollout history deployment/nginx-deployment --revision=2 # To rollback to a specific revision

# To update the deployment

kubectl set image deployment/nginx-deployment nginx=nginx:1.161






