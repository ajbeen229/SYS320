clear

$scraped = Invoke-WebRequest -TimeoutSec 10 http://localhost/ToBeScraped.html

#9
#$scraped.Links.Count

#10
#$scraped.Links

#11
#$scraped.Links | Select outerText, href

#12
#$h2 = $scraped.ParsedHtml.body.getElementsByTagName("h2") | Select outerText
#$h2

#13
$div1 = $scraped.ParsedHtml.body.getElementsByTagName("div") |`
Where { $_.getAttributeNode("class").value -like "div-1" } | Select innerText
$div1