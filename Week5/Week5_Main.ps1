clear
. (Join-Path $PSScriptRoot Week5_Scraping.ps1)

$classes = getclasses
#$classes

# List classes for specific professor
#$classes | Select * | Where { $_.Instructor -like "*Furkan*" }

# List classes in Joyce 310 on Mondays with formatting
<#
$classes | Where { ($_.Location -like "JOYC 310") -and ($_.Days -contains "Monday") } `
         | Sort-Object "Start Time" `
         | Format-Table "Start Time", "End Time", "Class Code"
#>

# Get all of the ITS instructors' names

$ITS_Instructors = $classes | Where { ($_."Class Code" -like "SYS*") -or `
                                      ($_."Class Code" -like "SEC*") -or `
                                      ($_."Class Code" -like "NET*") -or `
                                      ($_."Class Code" -like "FOR*") -or `
                                      ($_."Class Code" -like "CSI*") -or `
                                      ($_."Class Code" -like "DAT*") }`
                            | Select "Instructor"`
                            | Sort-Object "Instructor" -Unique
#$ITS_Instructors


# Group the instructors based on the number of classes they're teaching and sort by number of classes
$classes | Where { $_.Instructor -in $ITS_Instructors.Instructor } `
         | Group-Object "Instructor" | Select-Object Count,Name | Sort-Object Count -Descending