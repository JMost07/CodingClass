$json = Get-Content "$Home\Documents\Church\Programming\ASV_bible.json" | ConvertFrom-Json -AsHashtable

# Create the root object
$Bible = [PSCustomObject]@{}

foreach ($book in $json.GetEnumerator()) {
    $bookName = $book.Key

    # Create book object if it doesn't exist
    Add-Member -InputObject $Bible -MemberType NoteProperty -Name $bookName -Value ([PSCustomObject]@{})

    foreach ($chapter in $book.Value.GetEnumerator()) {
        $chapterNumber = $chapter.Key

        # Create chapter object
        Add-Member -InputObject $Bible.$bookName -MemberType NoteProperty -Name $chapterNumber -Value ([PSCustomObject]@{})

        foreach ($verse in $chapter.Value.GetEnumerator()) {
            $verseNumber = $verse.Key
            $verseText   = $verse.Value

            # Add verse text directly as a property of the chapter
            Add-Member -InputObject $Bible.$bookName.$chapterNumber -MemberType NoteProperty -Name $verseNumber -Value $verseText
        }
    }
}

Function Get-Sound {
<#
.SYNOPSIS
Plays a sounds from text input. 
.DESCRIPTION
Plays a sound 
.EXAMPLE

#>
[CmdletBinding()]
param (
    [Parameter(
        Position = 0,
        ValueFromPipeline =$true,
        Mandatory = $true
        )]
    [string]$Line,
    [int]$Volume = 100,
    [int]$Rate = 0,
    [switch]$male,
    [switch]$female
)
# Create a new SpVoice objects
$voice = New-Object -ComObject Sapi.spvoice
if ($male) {
   $Voice.Voice = $voice.GetVoices().Item(0)
}
if ($female) {
    $Voice.Voice = $voice.GetVoices().Item(1)
 }

# Set the speed - positive numbers are faster, negative numbers, slower
$voice.rate = $Rate
$voice.Volume = $Volume
# Say something
$voice.speak($Line) | Out-Null
}

function Start-Bible {
# Load Windows Forms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create Form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Bible Verse Reader"
$form.Size = New-Object System.Drawing.Size(500,350)
$form.StartPosition = "CenterScreen"

# --- Book Dropdown ---
$labelBook = New-Object System.Windows.Forms.Label
$labelBook.Text = "Book:"
$labelBook.Autosize = $true
$labelBook.Location = New-Object System.Drawing.Point(20,20)
$form.Controls.Add($labelBook)

$comboBook = New-Object System.Windows.Forms.ComboBox
$comboBook.Location = New-Object System.Drawing.Point(100,15)
$comboBook.Size = New-Object System.Drawing.Size(350,25)
$comboBook.DropDownStyle = 'DropDownList'
$form.Controls.Add($comboBook)

# --- Chapter Dropdown ---
$labelChapter = New-Object System.Windows.Forms.Label
$labelChapter.Text = "Chapter:"
$labelChapter.Autosize = $true
$labelChapter.Location = New-Object System.Drawing.Point(20,60)
$form.Controls.Add($labelChapter)

$comboChapter = New-Object System.Windows.Forms.ComboBox
$comboChapter.Location = New-Object System.Drawing.Point(100,55)
$comboChapter.Size = New-Object System.Drawing.Size(100,25)
$comboChapter.DropDownStyle = 'DropDownList'
$form.Controls.Add($comboChapter)

# --- Verse Dropdown ---
$labelVerse = New-Object System.Windows.Forms.Label
$labelVerse.Text = "Verse:"
$labelVerse.Autosize = $true
$labelVerse.Location = New-Object System.Drawing.Point(220,60)
$form.Controls.Add($labelVerse)

$comboVerse = New-Object System.Windows.Forms.ComboBox
$comboVerse.Location = New-Object System.Drawing.Point(280,55)
$comboVerse.Size = New-Object System.Drawing.Size(170,25)
$comboVerse.DropDownStyle = 'DropDownList'
$form.Controls.Add($comboVerse)

# --- Verse Text Display ---
$textVerse = New-Object System.Windows.Forms.TextBox
$textVerse.Location = New-Object System.Drawing.Point(20,100)
$textVerse.Multiline = $true
$textVerse.ReadOnly = $true
$textVerse.ScrollBars = 'Vertical'
$textVerse.Size = New-Object System.Drawing.Size(440,150)
$form.Controls.Add($textVerse)

# --- Play Button ---
$btnPlay = New-Object System.Windows.Forms.Button
$btnPlay.Text = "▶ Play Verse"
$btnPlay.Location = New-Object System.Drawing.Point(20,270)
$btnPlay.Size = New-Object System.Drawing.Size(440,30)
$form.Controls.Add($btnPlay)

# --- Populate Book Dropdown ---
$comboBook.Items.AddRange(($Bible.PSObject.Properties.Name))

# --- Events ---
$comboBook.Add_SelectedIndexChanged({
    $comboChapter.Items.Clear()
    $comboVerse.Items.Clear()
    $textVerse.Text = ""

    $selectedBook = $comboBook.SelectedItem
    $chapters = ($Bible.$selectedBook.PSObject.Properties.Name | Sort-Object {[int]$_})
    $comboChapter.Items.AddRange($chapters)
})

$comboChapter.Add_SelectedIndexChanged({
    $comboVerse.Items.Clear()
    $textVerse.Text = ""

    $selectedBook = $comboBook.SelectedItem
    $selectedChapter = $comboChapter.SelectedItem
    $verses = ($Bible.$selectedBook.$selectedChapter.PSObject.Properties.Name | Sort-Object {[int]$_})
    $comboVerse.Items.AddRange($verses)
})

$comboVerse.Add_SelectedIndexChanged({
    $selectedBook = $comboBook.SelectedItem
    $selectedChapter = $comboChapter.SelectedItem
    $selectedVerse = $comboVerse.SelectedItem

    $textVerse.Text = $Bible.$selectedBook.$selectedChapter.$selectedVerse
})

$btnPlay.Add_Click({
    $selectedBook = $comboBook.SelectedItem
    $selectedChapter = $comboChapter.SelectedItem
    $selectedVerse = $comboVerse.SelectedItem

    if ($selectedBook -and $selectedChapter -and $selectedVerse) {
        $verseText = $Bible.$selectedBook.$selectedChapter.$selectedVerse
        Get-Sound $verseText
    } else {
        [System.Windows.Forms.MessageBox]::Show("Please select a Book, Chapter, and Verse first.","Missing Selection")
    }
})

# Show GUI
[void]$form.ShowDialog()
}
