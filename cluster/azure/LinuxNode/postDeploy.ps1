param(
[string]$server="52.184.189.135"
)
process {
    $scripts = @("./LinuxNode/setupYum.sh", "./LinuxNode/installGit.sh", "./LinuxNode/installGo.sh", "./LinuxNode/installDocker.sh", "./LinuxNode/installEtcd.sh", "./LinuxNode/installCFSSL.sh", "./LinuxNode/copyGoWorkspaceToRoot.sh", "./LinuxNode/installKubernetes.sh" )
    
    if(Test-Path ./LinuxNode/postDeploy.sh) {
        Remove-Item ./LinuxNode/postDeploy.sh
    }

    if(Test-Path ./LinuxNode/input.sh) {
        Remove-Item ./LinuxNode/input.sh
    }

    $scripts | % { gc $_ } | Add-Content ./LinuxNode/input.sh

    gc ./LinuxNode/input.sh | ? { $_ -notlike "*Press any key*" } | sc ./LinuxNode/postDeploy.sh
    
    Remove-Item ./LinuxNode/input.sh

    $credential = Get-Credential -Message "Input the username and password for $server."
    $admin = $credential.UserName

    # Run Post Deploy Script
    putty -ssh -t -v -pw $credential.GetNetworkCredential().Password  "$admin@$server" -m ./LinuxNode/postDeploy.sh
    "Kubernetes is now building and will be running shortly."
}