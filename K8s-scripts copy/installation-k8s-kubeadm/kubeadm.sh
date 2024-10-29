# Install a contaner runtime

# Setup Cgroup driver

sudo vi /etc/containerd/onfig.toml

# Restart containerd

# Install kubeadm

sudo apt update
sudo apt install -y apt-transport-https
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install -y kubeadm

# Install kubelet and kubectl

sudo apt install -y kubelet kubectl
sudo apt-mark hold kubelet kubeadm

# To create our K8s cluster

kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.56.2

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# To add the worker nodes to the cluster

kubeadm join --token 123456.1234567890123456 --discovery-token-ca-cert-hash sha256:1234567890123456789012345678901234567890123456789012345678901234 192.168.56.3







