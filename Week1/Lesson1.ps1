[string]$words = "Hello World"
Write-Output $words

$Name = "Joshua" 
$sentence = "Hello $Name, $words"
$sentence


[bool]$TrueStatus = $True
$TrueStatus
$Wrong = $false
$Wrong

[int]$Five = 5
Write-Output $Five
[int]$Three = 3
Write-Output $Three
$eight = $five+$Three
Write-Output $eight

#what happens if we put quotes around an integer
$ThreeString = "3"
$FiveString = "5"
$eightString = $FiveString+$ThreeString
$eightString

$3 = [int]$ThreeString
$3 + 5

[datetime]$Now = Get-Date
Write-Output $Now
$now.AddDays(1)
$now.AddHours(-10)
$now.DayOfWeek
$now.DayOfYear
#Windows epoch counts from
$RightNow = 1758493424
[dateTime]$RightNow

$date = Get-Date -Format yyyyMMddHHmm
$date