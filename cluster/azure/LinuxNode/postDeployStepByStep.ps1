param(
[string]$server="52.184.189.135"
)
process {
    $credential = Get-Credential -Message "Input the username and password for $server."
    $admin = $credential.UserName

    # Install Yum-Utils
    putty -ssh -t -pw $credential.GetNetworkCredential().Password  "$admin@$server" -m ./LinuxNode/setupYum.sh
    "Yum setup complete, press enter to continue."
    Read-Host

    #Install Git
    putty -ssh -t -pw $credential.GetNetworkCredential().Password "$admin@$server" -m ./LinuxNode/installGit.sh
    "Git setup complete, press enter to continue."
    Read-Host

    # Install Go
    putty -ssh -t -pw $credential.GetNetworkCredential().Password  "$admin@$server" -m ./LinuxNode/installGo.sh
    "Go setup complete, press enter to continue."
    Read-Host

    # Install Docker
    putty -ssh -t -pw $credential.GetNetworkCredential().Password "$admin@$server" -m ./LinuxNode/installDocker.sh
    "Docker setup complete, press enter to continue."
    Read-Host

    # Install Etcd
    putty -ssh -t -pw $credential.GetNetworkCredential().Password "$admin@$server" -m ./LinuxNode/installEtcd.sh
    "Etcd setup complete, press enter to continue."
    Read-Host

    # Install CFSSL
    putty -ssh -t -pw $credential.GetNetworkCredential().Password "$admin@$server" -m ./LinuxNode/installCFSSL.sh
    "CFSSL setup complete, press enter to continue."
    Read-Host
    
    # Setup root workspace with Go files
    putty -ssh -t -pw $credential.GetNetworkCredential().Password "$admin@$server" -m ./LinuxNode/copyGoWorkspaceToRoot.sh
    "Copy Go files and workspace complete, press enter to continue."
    Read-Host

    # Run Kubernetes
    putty -ssh -t -pw $credential.GetNetworkCredential().Password "$admin@$server" -m ./LinuxNode/installKubernetes.sh
    "Kubernetes is now running, press enter to continue."
    Read-Host
}