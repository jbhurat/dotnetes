# Install CNI Plugin
sudo mkdir -p /opt/cni
wget https://storage.googleapis.com/kubernetes-release/network-plugins/cni-c864f0e1ea73719b8f4582402b0847064f9883b0.tar.gz
sudo tar -xvf cni-c864f0e1ea73719b8f4582402b0847064f9883b0.tar.gz -C /opt/cni

# Install kubernetes
cd ~
git clone --depth=1 https://github.com/kubernetes/kubernetes.git

# Replace Cluster CIDR
sed -i 's/--cluster-cidr=10.1.0.0\/16/--cluster-cidr=192.168.0.0\/16/g' ./kubernetes/hack/local-up-cluster.sh

# Set bindings for insecure to 0.0.0.0
sed -i '/--bind-address="${API_BIND_ADDR}"/d' ./kubernetes/hack/local-up-cluster.sh
sed -i 's/--insecure-bind-address="${API_HOST_IP}"/--insecure-bind-address="0.0.0.0"/g' ./kubernetes/hack/local-up-cluster.sh

# Copy to root
sudo cp ~/work /root/ -rfv
sudo cp ~/kubernetes/ /root/ -rfv
sudo iptables -F
sudo su - <<EOF
cd kubernetes
NET_PLUGIN=kubenet hack/local-up-cluster.sh
EOF
