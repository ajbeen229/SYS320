function readConfiguration() {

    $content = Get-Content -Path C:\Users\champuser\Documents\SYS320\Week7_Scripts\configuration.txt
    $contentTable = [pscustomobject]@{ 
                                        "Days" = $content[0];
                                        "ExecutionTime" = $content[1];
                                        }
    $contentTable | Out-String

    return $contentTable

}

function changeConfiguration() {

    $newDays = Read-Host -Prompt "Number of days (positive number)"
    while($newDays -notmatch "^\d+$") {
        $newDays = Read-Host "Please enter days correctly"
    }

    $newTime = Read-Host -Prompt "Execution time (hh:mm am|pm)"
    while($newTime -notmatch "\d{1,2}:\d{2} (.*?am|pm)") {
        $newTime = Read-Host "Please enter time correctly"
    }

    Set-Content -Path .\configuration.txt -Value "$newDays`n$newTime"
    Write-Host "Configuration Changed." | Out-String

}

function menu() {

    $Prompt = "`n[1] Show Configuration"
    $Prompt += "`n[2] Edit Configuration"
    $Prompt += "`n[3] Exit"

    while($true) {
    
        clear
        Write-Host $Prompt
        $option = Read-Host -Prompt "`nEnter an option"

        if($option -eq 1) {

            readConfiguration

        }

        elseif($option -eq 2) {

            changeConfiguration
    
        }

        elseif($option -eq 3) { break }

        Read-Host

    }

}

#menu