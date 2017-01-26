param(
    [Parameter(Mandatory=$true)]
    [string]$MasterPublicIp,
    [Parameter(Mandatory=$true)]
    [string]$MasterCIDR,
    [Parameter(Mandatory=$true)]
    [string]$MasterPrivateIp,   
    [Parameter(Mandatory=$true)]
    [string]$NodeCIDR,
    [Parameter(Mandatory=$true)]
    [string]$NodePrivateIp,    
    [Parameter(Mandatory=$true)]
    [string]$NodeTransparentCIDR
)
process {
    $credential = Get-Credential -Message "Please enter the username and password of the master node"
    $admin = $credential.UserName
    $server = $MasterPublicIp
    $interface = (route print -4 |  ? { $_  -match "Hyper-V Virtual Ethernet Adapter"} | ? { $_ -notmatch "#" })
    $interfaceIndex = $interface.substring(0, $interface.IndexOf('.'))
    route add $MasterCIDR.Substring(0, $MasterCIDR.LastIndexOf("/")) mask "255.255.255.0" $MasterPrivateIp if $interfaceIndex -p
    "ip route add $NodeCIDR via $NodePrivateIp"
    putty -ssh -t -v -pw $credential.GetNetworkCredential().Password  "$admin@$server" -m 
}