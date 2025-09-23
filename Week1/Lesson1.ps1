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

[int]32 # this is a 32 bit number. in binary its look like this 
0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
The maximum value for a 32 bit integer is 2,147,483,647
[int64]64 is a Long and its a 64 bit integer. it looks like this in binary 
0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
The maximum value for a 64 bit integer is 
9,223,372,036,854,775,807
nine quintillion, two hundred twenty-three quadrillion, three hundred seventy-two trillion, thirty-six billion, eight hundred fifty-four million, seven hundred seventy-five thousand, eight hundres seven
#then there a decimals and floats. We won't be working with a lot of numbers but you should be aware of their types.


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



if ($WantToCode -eq $true) {
    $YouWillBeThere = $true
    $CoolFactor = 100
} else {
    $YouWillBeThere = $false
    $CoolFactor = 0
}



$YouWillBeThere
$CoolFactor
