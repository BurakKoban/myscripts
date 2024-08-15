kubeadm upgrade plan # To see the upgrade plan

kubeadm upgrade apply # To apply the upgrade

kubeadm upgrade node # To upgrade the node

# Find the latest 1.27 version in the list.
# It should look like 1.27.x-*, where x is the latest patch.
apt update
apt-cache madison kubeadm

# replace x in 1.27.x-* with the latest patch version
apt-mark unhold kubeadm && \
apt-get update && apt-get install -y kubeadm='1.27.0-00' && \
apt-mark hold kubeadm

kubeadm version

kubeadm upgrade plan

# replace x with the patch version you picked for this upgrade
sudo kubeadm upgrade apply v1.27.x


# To upgrade kubelet

apt-get upgrade kubelet
apt install kubelet=1.27.0-00

apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet='1.27.0-00' kubectl='1.27.0-00' && \
apt-mark hold kubelet kubectl

