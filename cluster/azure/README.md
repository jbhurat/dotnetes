# Introduction
The files directories and subdirectors in this folder are intended to setup demo environments for Kubernetes with Windows Containers.
# Directory Details
```
azure - This Directory
|  deploy.ps1 - Powershell script for running Azure resoure manager deployments. 
|  deploy.sh - sh script for running Azure resource manager deployments from linux.
|  deployer.rb -  module for running Azure resoure manager deployments from ruby.
|  DeploymentHelper.cs - class for running Azure resource manager deployments from .NET.
|  parameters.json - parameters to be applied to the resource manager template.
|  README.md - this file.
|  template.json - template defining the deployment to create a set of servers.
|
└───LinuxNode - contains scripts to deploy a single Linux node in Azure Resource Manager and to install Kubernetes and its dependencies.
|   |  installCFSSL.sh - script to install CFSSL library to support Kubernetes.
|   |  installDocker.sh - script to install Docker to support Kubernetes.
|   |  installEtcd.sh - script to install Etcd to support Kubernetes.
|   |  installGit.sh - script to installGit to pull various source code.
|   |  installGo.sh - script to install Go.
|   |  installKubernetes.sh - script to install Kubernetes.
|   |  parameters.json - parameters to be applied to the resource manager template.
|   |  postDeploy.ps - Powershell script to setup Kubernetes and its dependencies against a running Centos node.
|   |  postDeployStepByStep.ps1 - Powershell script to setup Kubernetes and its dependencies against a running Centos node, with pauses between steps.
|   |  setupYum.sh - script to setup yum and yum-utils to pull Kubernetes dependencies.
|   |  template.json - template defining a single CentOS deployment.
|
└───WindowsNode - contains scripts to deploy a single Windows Server 2016 node ins Azure Resource Manager and to install Kubernetes and its dependencies.
|   |  parameters.json - parameters to be applied to the resource manager template.
|   |  template.json - template defining a single Windows Server 2016 node.
```
# Create a set of servers
The attached ARM template creates a Kubernetes cluster with 1 Linux node (KubeLin01) and 2 Windows nodes (KubeWin01 and KubeWin02) in a Resource Group called AzureKubeDemo. Resources in AzueKubeDemo ResourceGroup are:
* KubeLin01 - Centos 7 VM of Standard D2 Size
* KubeWin01 - Windows Server 2016 TP5 with Containers VM of Standard D2 Size
* KubeWin02 - Windows Server 2016 TP5 with Containers VM of Standard D2 Size
* Ethernet1 - NIC attached to KubeWin01 VM. Has a private and a public IP configured
* Ethernet2 - NIC attached to KubeWin01 VM. Has a private IP configured, docker overrides this NIC when docker transparent network is created.
* Ethernet3 - NIC attached to KubeWin02 VM. Has a private and public IP configured
* Ethernet4 - NIC attached to KubeWin02 VM. Has a private IP configured, docker overrides this NIC when docker transparent network is created.
* Ethernet5 - NIC attached to KubeLin01 VM. Has a private and public IP configured.
* UDR-Win01 - User defined routes defined to route traffic for containers to the right hosts
* AzureKubeNet - Virtual Network consisting of Ethernet1 - Ethernet5 NICs
* AzureKubeStore - Storage account used for the containers

# Create an Individual Linux node
1.  Modify the ```./LinuxNode/parameters.json``` file.
2.  Log into Azure Resource Manager.
     ```Powershell
     Login-AzureRmAccount
     ```
4.  Run the deploy.ps1 script against the template and parameters json files.
     ```Powershell
     .\deploy.ps1 -subscriptionId (Get-AzureRmContext).Subscription.SubscriptionId -resourceGroupName KubeDemo -resourceGroupLocation "East US 2" -deploymentName KubeDemo -templateFilePath .\LinuxNode\template.json -parametersFilePath .\LinuxNode\parameters.json
     ```
5.  Run the postDeploy.ps1 or postDeployStepByStep.ps1 script with the server IP that was just created.
    ```Powershell
    .\LinuxNode\postDeploy.ps1 -server <IP Address>

    .\LinuxNode\postDeployStepByStep.ps1 -server <IP Address>
    ```
6. Once the script is complete the linux server will have a running Kubernetes cluster good for local development per the Kubernetes [Getting Started Locally](https://github.com/kubernetes/community/blob/master/contributors/devel/running-locally.md) documentation.

# Create an individual Windows node
1.  Modify the ```./WindowsNode.json``` file.
2.  Log into Azure Resource Manager.
     ```Powershell
     Login-AzureRmAccount
     ```
4.  Run the deploy.ps1 script against the template and parameters json files.
     ```Powershell
     .\deploy.ps1 -subscriptionId (Get-AzureRmContext).Subscription.SubscriptionId -resourceGroupName KubeDemo -resourceGroupLocation "East US 2" -deploymentName KubeDemo -templateFilePath .\WindowsNode\template.json -parametersFilePath .\WindowsNode\parameters.json
     ```
5.  Complete the setup of the Windows Server 2016 nodes per the Kubernetes [Windows Server Containers](https://kubernetes.io/docs/getting-started-guides/windows/) documentation.