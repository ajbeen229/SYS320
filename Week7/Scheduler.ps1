function DisableAutoRun() {

    $scheduledTasks = Get-ScheduledTask | Where-Object { $_.TaskName -like "myTask" }

    if($scheduledTasks -ne $null) {

        Write-Host "Unregistering the task." | Out-String
        Unregister-ScheduledTask -TaskName 'myTask' -Confirm:$false

    }
    else {

        Write-Host "The task is not registered." | Out-String

    }

}

function chooseTimeToRun($time) {

    $scheduledTasks = Get-ScheduledTask | Where-Object { $_.TaskName -like "myTask" }

    if($scheduledTasks -ne $null) {

        Write-Host "The task already exists." | Out-String
        DisableAutoRun

    }

    Write-host "Creating New Task." | Out-String

    $action = New-ScheduledTaskAction -Execute "powershell.exe" `
              -argument "-File `"C:\Users\champuser\Documents\SYS320\Week7_Scripts\Main.ps1`""
    $trigger = New-ScheduledTaskTrigger -Daily -At $time
    $principal = New-ScheduledTaskPrincipal -UserId 'champuser' -RunLevel Highest
    $settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -WakeToRun
    $task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings

    Register-ScheduledTask 'myTask' -InputObject $task

    Get-ScheduledTask | Where-Object { $_.TaskName -like "myTask" }

}