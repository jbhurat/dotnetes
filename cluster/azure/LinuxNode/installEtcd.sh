git clone https://github.com/coreos/etcd.git
cd etcd
./build
sudo mv ./bin/* /usr/local/bin/
read -p "Press any key to continue."