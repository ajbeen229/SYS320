clear

function getIPs($page, $code, $browser) {

    $content = Get-Content .\*.log | Select-String $page | Select-String $code | Select-String $browser

    $regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
    $regex.Matches($content) | Select-Object Value

}