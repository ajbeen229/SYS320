clear

function getIOC() {

    $page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.6/IOC.html

    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")

    $table = @()
    for($i = 1; $i -lt $trs.length; $i++) {

        $tds = $trs[$i].getElementsByTagName("td")
        $table += [pscustomobject]@{
            "Pattern" = $tds[0].innerText
            "Description" = $tds[1].innerText
        }

    }

    return $table

}

function obtainLogs() {

    $unformatted = Get-Content $env:USERPROFILE\Downloads\access.log

    $table = @()

    for($i = 0; $i -lt $unformatted.length; $i++) {
        
        $sections = $unformatted[$i].Split(" ")

        $table += [pscustomobject]@{

            "IP" = $sections[0];
            "Time" = $sections[3].Trim('[');
            "Method" = $sections[5].Trim('"');
            "Page" = $sections[6];
            "Protocol" = $sections[7];
            "Response" = $sections[8];
            "Referrer" = $sections[10];

        }

    }

    return $table

}

function filterLogs() {

    $patternList = getIOC | Select Pattern

    $logs = obtainLogs

    $newTable = @()

    foreach($row in $logs) {
        foreach($string in $patternList) {
            if($row.Page -like "*" + $string.Pattern + "*") {

                $newTable += $row
                break

            }

        }

    }

    return $newTable

}

$filteredTable = filterLogs
$filteredTable | Format-Table | Out-String