kubectl get nodes -o json > /opt/outputs/nodes.json

kubectl get node node01 -o json > /opt/outputs/node01.json

# To get the node names

kubectl get nodes -o=jsonpath='{.items[*].metadata.name}' > /opt/outputs/node_names.txt

# To get the osImages of all the nodes

kubectl get nodes -o jsonpath='{.items[*].status.nodeInfo.osImage}' > /opt/outputs/nodes_os.txt

# To get the users in the kubeconfig

kubectl config view --kubeconfig=my-kube-config  -o jsonpath="{.users[*].name}" > /opt/outputs/users.txt

# To sort Persistent Volumes based on their capacity

kubectl get pv --sort-by=.spec.capacity.storage > /opt/outputs/storage-capacity-sorted.txt

# To query to identify the context configured for the aws-user in the my-kube-config context file

kubectl config view --kubeconfig=my-kube-config -o jsonpath="{.contexts[?(@.context.user=='aws-user')].name}" > /opt/outputs/aws-context-name

# How to get the capacity of the nodes in columns

kubectl get nodes -o=jsonpath='{.items[*].,metadata.name}{"\n"}{.items[*].status.capacity.cpu}'

# master  node01
# 4       4

kubectl get nodes -o=custom-columns=NODE:.metadata.name,CPU:.status.capacity.cpu

# NODE    CPU
# master  4
# node01  4

# Sort-by option

kubectl get nodes --sort-by=.status.capacity.cpu

# NAME    STATUS   ROLES    AGE       VERSION
# master  Ready    master   2d17h     v1.11.3
# node01  Ready    <none>   2d17h     v1.11.3

