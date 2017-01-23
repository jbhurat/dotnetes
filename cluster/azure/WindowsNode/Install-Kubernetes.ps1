# Install Kubernetes

# Grab the source
mkdir -p $GOPATH/src/k8s.io
cd $GOPATH/src/k8s.io
git clone https://github.com/apprenda/kubernetes

# Build Kubelet
cd $GOPATH/src/k8s.io/kubernetes
git checkout windows_infra_container
KUBE_BUILD_PLATFORMS=windows/amd64 make WHAT=cmd/kubelet

# Build Kube-proxy
cd $GOPATH/src/k8s.io/kubernetes
git checkout windows_kube_proxy
KUBE_BUILD_PLATFORMS=windows/amd64 make WHAT=cmd/kube-proxy

# Copy to C:\Kubernetes
mkdir -p C:/Kubernetes
cp $GOPATH/src/k8s.io/kubernetes/*.exe C:/Kubernetes/
"Press any key to continue."; Read-Host
