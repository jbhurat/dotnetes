sudo yum-config-manager --add-repo https://docs.docker.com/engine/installation/linux/repo_files/centos/docker.repo
sudo yum -y install docker-engine
sudo groupadd docker
sudo usermod -aG docker $USER
sudo usermod -aG docker root
sudo systemctl enable docker
read -p "Press any key to continue."