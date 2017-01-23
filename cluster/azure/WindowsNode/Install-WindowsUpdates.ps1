$Criteria = "IsInstalled=0 and Type='Software'"
$Searcher = New-Object -ComObject Microsoft.Update.Searcher
try {
    $SearchResult = $Searcher.Search($Criteria).Updates
    if ($SearchResult.Count -eq 0) {
        Write-Output "There are no applicable updates."
        exit
    } 
    else {
        $Session = New-Object -ComObject Microsoft.Update.Session
        $Downloader = $Session.CreateUpdateDownloader()
        $Downloader.Updates = $SearchResult
        $Downloader.Download()
        $Installer = New-Object -ComObject Microsoft.Update.Installer
        $Installer.Updates = $SearchResult
        $Result = $Installer.Install()
    }
}
catch {
    Write-Output "There are no applicable updates."
}

WSUSUpdate
#If ($Result.rebootRequired) { Restart-Computer }
"Press any key to continue."; Read-Host