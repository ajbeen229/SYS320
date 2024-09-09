. (Join-Path $PSScriptRoot Week3.ps1)
clear

# Get logons and logoffs for last 15 days
# Parameter is automatically set to 15
getWinLogon

# Get power on and power off logs from last 25 days
# Parameter is automatically set to 25
getPowerOnOff