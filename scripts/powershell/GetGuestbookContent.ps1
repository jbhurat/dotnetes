param (
    [Parameter(Mandatory=$true)][string]$url
)

$webresponse = Invoke-WebRequest $url -DisableKeepAlive

$webresponse.Content