param(
    [string]$PodCIDR,
    [string]$transparentIpAddress,
    [string]$networkName
) process 
{
    docker network create -d transparent --gateway $transparentIpAddress --subnet $PodCIDR $networkName
    netsh.exe interface ipv4 set address name="vEthernet (HNSTransparent)" source="static" address=$transparentIpAddress
    $env:CONTAINER_NETWORK="$networkName"
    [Environment]::SetEnvironmentVariable("CONTAINER_NETWORK", "$networkName", "Machine")
    $env:INTERFACE_TO_ADD_SERVICE_IP = "vEthernet (HNS Internal NIC)"
    [Environment]::SetEnvironmentVariable("INTERFACE_TO_ADD_SERVICE_IP", "vEthernet (HNS Internal NIC)", "Machine")
    
}