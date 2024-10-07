# Starting at Week6_Scripts
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot \..\Week4_Scripts\Week4_Parse.ps1)
. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot \..\Week2_Scripts\Process-Management.ps1)

$Prompt = "`n"
$Prompt += "1 - Display Apache Logs`n"
$Prompt += "2 - Display Failed Logins`n"
$Prompt += "3 - Display At-Risk Users`n"
$Prompt += "4 - Toggle Chrome`n"
$Prompt += "5 - Quit`n"

while($true) {

    clear

    Write-Host $Prompt | Out-String
    $option = Read-Host -Prompt "What would you like to do? (1-5)"

    if($option -eq 1) {
        
        $logs = apacheLogs 2
        $logs

        Write-Host "`nSuccessfully retrieved logs." | Out-String

    }

    elseif($option -eq 2) {

        $time = Read-Host -Prompt "`nHow far back would you like to see (default 10 days)"
        if(!$time) { $time = 10 }
        getFailedLogins $time

        Write-Host "`nSuccessfully retrieved failed logins." | Out-String

    }

    elseif($option -eq 3) {

        getAtRiskUsers
        Write-Host "`nSuccessfully retrieved at-risk users." | Out-String

    }

    elseif($option -eq 4) {

        openChrome
        Write-Host "`nSuccessfully toggled Chrome." | Out-String

    }

    elseif($option -eq 5) {

        Write-Host "`nQuitting..." | Out-String
        Sleep 1
        break

    }

    Read-Host

}