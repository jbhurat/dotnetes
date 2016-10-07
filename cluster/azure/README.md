# Kubernetes Cluster on Azure
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
