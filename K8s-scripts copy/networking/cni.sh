# To install the weave net: -

kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

# The path for all binaries of CNI supported plugins

/opt/cni/bin

# To see the CNI plugins

ls /etc/cni/net.d

