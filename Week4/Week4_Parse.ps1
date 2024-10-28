function apacheLogs($quantity=0) {
    
    if($quantity -eq 0) { $unformatted = Get-Content C:\xampp\apache\logs\access.log }
    else { $unformatted = Get-Content C:\xampp\apache\logs\access.log -Tail $quantity }

    $table = @()

    # make sure the data is splitable and not just one string
    $iter = 1
    if($quantity -ne 1) { $iter = $unformatted.Count }

    for($i = 0; $i -lt $iter; $i++) {
        
        if($quantity -eq 1) { $sections = $unformatted.Split(" "); }
        else { $sections = $unformatted[$i].Split(" ") }

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

$table = apacheLogs 2
$table