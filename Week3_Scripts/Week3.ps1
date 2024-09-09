clear

#1
#Get-EventLog System -Source Microsoft-Windows-Winlogon

#2
<#
$logons = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)
$logonTable = @()

for($i = 0; $i -lt $logons.Count; $i++) {
    $event = ""
    if($logons[$i].InstanceID -eq 7001) {$event = "Logon"}
    if($logons[$i].InstanceID -eq 7002) {$event = "Logoff"}

    $user = $logons[$i].ReplacementStrings[1]

    $logonTable += [pscustomobject]@{`
        "Time"  = $logons[$i].TimeGenerated;
        "Id"    = $logons[$i].InstanceId;
        "Event" = $event;
        "User"  = $user;
    }
}
$logonTable
#>

#3
<#
$input = -(Read-Host -Prompt "Number of days to retrieve logs from: ")
$logons = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays($input)
$logonTable = @()

for($i = 0; $i -lt $logons.Count; $i++) {
    $event = ""
    if($logons[$i].InstanceID -eq 7001) {$event = "Logon"}
    if($logons[$i].InstanceID -eq 7002) {$event = "Logoff"}

    $userSID = New-Object System.Security.Principal.SecurityIdentifier($logons[$i].ReplacementStrings[1])
    $user = $userSID.Translate([System.Security.Principal.NTAccount])

    $logonTable += [pscustomobject]@{`
        "Time"  = $logons[$i].TimeGenerated;
        "Id"    = $logons[$i].InstanceId;
        "Event" = $event;
        "User"  = $user;
    }
}
$logonTable
#>

#4

function getWinLogon {

    param (
        [Parameter(Mandatory=$false)] [int]$days = 15
    )

    $logons = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$days)
    $logonTable = @()

    for($i = 0; $i -lt $logons.Count; $i++) {
        $event = ""
        if($logons[$i].InstanceID -eq 7001) {$event = "Logon"}
        if($logons[$i].InstanceID -eq 7002) {$event = "Logoff"}

        $userSID = New-Object System.Security.Principal.SecurityIdentifier($logons[$i].ReplacementStrings[1])
        $user = $userSID.Translate([System.Security.Principal.NTAccount])

        $logonTable += [pscustomobject]@{`
            "Time"  = $logons[$i].TimeGenerated;
            "Id"    = $logons[$i].InstanceId;
            "Event" = $event;
            "User"  = $user;
        }
    }
    $logonTable

}

#$input = -(Read-Host -Prompt "Number of days to retrieve logs from: ")
#getWinLogon $input

#5
function getPowerOnOff {
    
    param (
        [Parameter(Mandatory=$false)] [int]$days = 25
    )

    $logs = Get-EventLog System -Source EventLog -After (Get-Date).AddDays(-$days) | Where-Object {$_.EventID -in @(6005, 6006)}
    $powerOnOffTable = @()
    $user = "System"

    for($i = 0; $i -lt $logs.Count; $i++) {
        $event = ""
        if($logs[$i].EventID -eq 6005) {$event = "PowerOn"}
        if($logs[$i].EventID -eq 6006) {$event = "PowerOff"}

        $powerOnOffTable += [pscustomobject]@{
            "Time"  = $logs[$i].TimeGenerated;
            "Id"    = $logs[$i].EventID;
            "Event" = $event;
            "User"  = $user;
        }
    }
    $powerOnOffTable

}