clear

function getClasses() {

    $page = Invoke-WebRequest -TimeoutSec 10 http://localhost/Courses-1.html
    #rows
    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")

    $table = @()
    for ($i = 1; $i -lt $trs.length; $i++) {
        
        #columns
        $tds = $trs[$i].getElementsByTagName("td")

        $times = $tds[5].innerText.split("-")

        $table += [pscustomobject]@{ "Class Code" = $tds[0].innerText;
                                    "Class Name" = $tds[1].innerText;
                                    "Days"       = $tds[4].innerText;
                                    "Start Time" = $times[0];
                                    "End Time"   = $times[1];
                                    "Instructor" = $tds[6].innerText;
                                    "Location"   = $tds[9].innerText;
                                  }
    }
    
    dayTranslator $table

    return $table
}

function dayTranslator($table) {

    foreach ($record in $table) {

        $days = @()

        if($record.Days -match "^M") { $days += "Monday" }
        if($record.Days -match "^T[^H][WTF]*") { $days += "Tuesday" }
        if($record.Days -match "\d*W\d*") { $days += "Wednesday" }
        if($record.Days -match "\d*TH\d*") { $days += "Thursday" }
        if($record.Days -match "\d*F\d*") { $days += "Friday" }

        $record.Days = $days
    
    }
    #return $table
}