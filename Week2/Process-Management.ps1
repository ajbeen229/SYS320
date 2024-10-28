clear

#1
#Get-Process | Where-Object { $_.ProcessName -like "C*" }

#2
#Get-Process | Where-Object { $_.Path -notlike "*system32*" } | Select ProcessName, Path

#3
<#
$ExportPath = New-Item -Path . -Name "stoppedservices.csv"
$Services = Get-Service |`
            Where-Object { $_.Status -eq "Stopped" } |`
            Sort-Object |`
            Export-Csv -Path $ExportPath
#>

#4
function openChrome() {
    if( (Get-Process | Where-Object {$_.Name -eq "chrome"}).Count -eq 0 ) {
        Start-Process chrome.exe '--new-window champlain.edu'
    } 
    else {
        Stop-Process -Name chrome
    }
}

#openChrome