sudo yum install -y yum-utils
sudo yum makecache fast
sudo yum install git -y
export VERSION="1.7.4"
export OS="linux"
export ARCH="amd64"
curl -O https://storage.googleapis.com/golang/go$VERSION.$OS-$ARCH.tar.gz
sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz
export GOPATH=$HOME/work
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin
cat <<EOF >> ~/go.sh
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/work
export PATH=$PATH:$GOPATH/bin
EOF
mkdir ~/work
sudo mkdir /root/work
sudo mv ~/go.sh /etc/profile.d/
. /etc/profile
sudo yum-config-manager --add-repo https://docs.docker.com/engine/installation/linux/repo_files/centos/docker.repo
sudo yum -y install docker-engine
sudo groupadd docker
sudo usermod -aG docker $USER
sudo usermod -aG docker root
sudo systemctl enable docker
git clone https://github.com/coreos/etcd.git
cd etcd
./build
sudo mv ./bin/* /usr/local/bin/
sudo yum install gcc -y
go get -u github.com/cloudflare/cfssl/cmd/...
sudo cp ~/work /root/ -rf
sudo cp ~/go /root/ -rf
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
