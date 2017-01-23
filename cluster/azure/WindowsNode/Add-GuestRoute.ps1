param(
    [Parameter(Mandatory=$true)]
    [string]$PodCIDR,
    [Parameter(Mandatory=$true)]
    [string]$PodTransparentIp
)
process {
    $interface = (route print -4 |  ? { $_  -match "Hyper-V Virtual Ethernet Adapter"} | ? { $_ -notmatch "#" })
    $interfaceIndex = $interface.substring(0, $interface.IndexOf('.'))
    route add "$PodCIDR" mask "255.255.255.0" "$PodTransparentIp" if $InterfaceIndex -p
}