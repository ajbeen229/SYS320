#clear
#1
#(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).IPAddress

#2
#(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).PrefixLength

#3
#Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_Net*" } | Sort-Object

#5
#Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" |` 
#Select DHCPServer |`
#Format-Table -HideTableHeaders

#7
#(Get-DnsClientServerAddress -AddressFamily IPv4 |`
#Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).ServerAddresses[0]

#8
$PS1_Directory = "C:\Users\champuser\Documents"
<#
cd $PS1_Directory
$files = (Get-ChildItem)
for ($i = 0; $i -le $files.Length; $i++) {
    if($files[$i].name -ilike "*ps1") {
        Write-Host $files[$i].name
    }
}
#>

#9
$folderpath = "$PS1_Directory\outfolder"
<#
if(Test-Path $folderpath) {
    Write-Host "Path Exists"
} else {
    New-Item -ItemType Directory -Path $folderpath
}
#>

#10
<#
$filepath = New-Item -Path $folderpath -Name "out.csv"
Get-ChildItem |`
Where-Object { $_.extension -EQ ".ps1" } |`
Export-Csv -Path $filepath
#>

#11

cd $PS1_Directory
$files = Get-ChildItem -Recurse -File
$files | Rename-Item -NewName { $_.Name -replace '.csv', '.log' }
Get-ChildItem -Recurse
#>