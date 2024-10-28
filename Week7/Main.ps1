. "C:\Users\champuser\Documents\SYS320\Week6_Scripts\Users.ps1"
. "C:\Users\champuser\Documents\SYS320\Week7_Scripts\Configuration.ps1"
. "C:\Users\champuser\Documents\SYS320\Week7_Scripts\Email.ps1"
. "C:\Users\champuser\Documents\SYS320\Week7_Scripts\Scheduler.ps1"

try {

    $configuration = readConfiguration

    $atRisk = getAtRiskUsers $configuration.Days

    sendAlertEmail ($atRisk | Format-Table | Out-String)

    chooseTimeToRun $configuration.ExecutionTime

}
catch {
    Write-Host $_
    Read-Host
}