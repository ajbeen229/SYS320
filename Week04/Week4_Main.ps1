#9
. (Join-Path $PSScriptRoot ApacheLogs.ps1)
getIPs "index.html" " 404 " "Chrome"

# Apache Logs Lab
. (Join-Path $PSScriptRoot Week4_Parse.ps1)
$tableRecords = apacheLogs
$tableRecords | Format-Table -AutoSize -Wrap