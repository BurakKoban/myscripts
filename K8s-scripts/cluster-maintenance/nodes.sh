kubectl drain node-1 --ignore-daemonsets # To terminate the pod on node-1 and re-create them on other nodes

kubectl uncordon node-1 # To re-activate the node to be re-scheduable again

kubectl cordon node-1 # To suspend the node to be re-scheduable again
