. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - List At-Risk Users`n"
$Prompt += "10 - Exit"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "`nPlease enter the username for the new user"
        $password = Read-Host -Prompt "Please enter the password for the new user"

        if(checkUser $name) {
           Write-Host "User already exists." | Out-String
           continue
        }

        if(-Not (checkPassword $password)) {
            Write-Host "Password does not meet requirements." | Out-String
        }
        $password = ConvertTo-SecureString $password -AsPlainText -Force

        createAUser $name $password

        Write-Host "`nUser: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "`nPlease enter the username for the user to be removed"

        if(-Not (checkUser $name)) {
            Write-Host "User does not exist."
            continue
        }

        removeAUser $name

        Write-Host "User: $name Removed." | Out-String
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "`nPlease enter the username for the user to be enabled"

        if(-Not (checkUser $name)) {
            Write-Host "User does not exist."
            continue
        }

        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "`nPlease enter the username for the user to be disabled"

        if(-Not (checkUser $name)) {
            Write-Host "User does not exist."
            continue
        }

        disableAUser $name

        Write-Host "User: $name Disabled." | Out-String
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "`nPlease enter the username for the user logs"

        if(-Not (checkUser $name)) {
            Write-Host "User does not exist."
            continue
        }

        $days = Read-Host "`nEnter number of days for past logs: "
        $userLogins = getLogInAndOffs $days

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "`nPlease enter the username for the user's failed login logs"

        if(-Not (checkUser $name)) {
            Write-Host "User does not exist."
            continue
        }

        $days = Read-Host "`nEnter number of days for past logs"
        $userLogins = getFailedLogins $days

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }

    elseif($choice -eq 9) {

        getAtRiskUsers

    }
    
    else {

        Write-Host "Invalid option. Please enter a number from the list." | Out-String

    }
    

}