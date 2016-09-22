# Add $listenAddress to "vEthernet (HNS Internal NIC)" interface and then add portproxy rule
param (
    [string]$listenAddress,
    [Parameter(Mandatory=$true)][string]$listenPort,
    [Parameter(Mandatory=$true)][string]$connectAddress,
    [Parameter(Mandatory=$true)][string]$connectPort
)

if($listenAddress) {	
    netsh interface ipv4 add address name="vEthernet (HNS Internal NIC)" address=$listenAddress
    # Sleep for a second after adding ip address for it to initialize properly
    Start-Sleep -s 1
    netsh interface portproxy add v4tov4 listenaddress=$listenAddress listenport=$listenport connectaddress=$connectAddress connectport=$connectPort
}
else {
    netsh interface portproxy add v4tov4 listenport=$listenport connectaddress=$connectAddress connectport=$connectPort
}