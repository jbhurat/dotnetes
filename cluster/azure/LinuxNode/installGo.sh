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