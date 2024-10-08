﻿clear

#2
#Get-Content .\access.log

#3
Get-Content C:\xampp\apache\logs\access.log -Tail 5

#4
#Get-Content .\access.log | Select-String ' 404 ', ' 400 '

#5
#Get-Content .\access.log | Select-String ' 200 ' -NotMatch

#6
#Get-ChildItem .\*.log | Select-String 'error'

#7
<#
$notfound = Get-Content .\access.log | Select-String ' 404 '
$regex = [regex] "[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"
$IPs = $regex.Matches($notfound)

$iplist = @()
for($i = 0; $i -lt $IPs.Count; $i++) {
    $iplist += [pscustomobject]@{ "IP" = $IPs[$i].Value; }
}
#$iplist | Where-Object {$_.IP -like "10.*"}
#>

#8
<#
$iplist |`
Where-Object {$_.IP -like "10.*"} |`
Group IP |`
Select-Object Count, Name
#>