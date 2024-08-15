kubectl top node

kubectl top pod

# To see the logs for a pod

kubectl logs -f event-simulator-pod

# If you have 2 containers in one pod, you need to specify the container's name

kubectl logs -f event-simulator-pod event-similator
