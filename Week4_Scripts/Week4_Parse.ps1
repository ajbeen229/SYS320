function apacheLogs() {

    $unformatted = Get-Content .\access.log
    $table = @()

    for($i = 0; $i -lt $unformatted.Count; $i++) {
    
        $sections = $unformatted[$i].Split(" ");

        $table += [pscustomobject]@{

            "IP" = $sections[0];
            "Time" = $sections[3].Trim('[');
            "Method" = $sections[5].Trim('"');
            "Page" = $sections[6];
            "Protocol" = $sections[7];
            "Response" = $sections[8];
            "Referrer" = $sections[10];
            "Client" = $sections[11..($sections.Count)];

        }

    }

    return $table | Where-Object {$_.IP -like "10.*"}

}