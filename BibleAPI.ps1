$Path = 'C:\temp\Key.json'
$Errorlog = "$Home\Documents\Church\Programming\ErrorLog.Txt"
if (!(Test-Path $Path)) {
    Write-Error "Credentials not found" | Out-File $Errorlog -Append -Force
    Exit 1
}
$key = Get-Content $Path | ConvertFrom-Json
$Header = @{ 'api-key' = $($key.Secret)
"Content-Type" = "application/json"}
$BibleId = '06125adad2d5898a-01' #American Standard Version
#$BibleID = 'de4e12af7f28f599-01' #King James
$BaseUrl = "https://api.scripture.api.bible/v1/bibles/$BibleId"

#($Response = Invoke-RestMethod -Uri $BaseUrl -Headers $Header -Method Get)

$uri = $BaseUrl + "/books"
$response = Invoke-RestMethod -Uri $uri -Headers $Header -Method Get
$NT = $response.data
$Book = 'John'
$bookId = ($NT | Where-Object name -eq $Book).id
$uri = $uri + "/" + $bookId + "/chapters"
$response = Invoke-RestMethod -Uri $uri -Headers $Header -Method Get



















[PSCustomObject]@{
    username = 'joshuardmosteller@gmail.com'
    password = '%Xj9diT@DC+8&r+'
} | ConvertTo-Json | Out-File $Path


