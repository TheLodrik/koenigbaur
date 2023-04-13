function Get-RandomPassword {
    param (
        [Parameter(
            Position=0,
            HelpMessage="Enter the desired length of the password"
        )]
        [int] $length,
        [Parameter(
            Position=1,
            HelpMessage="Enter a note that can be found in the log"
        )]
        [string] $note
    )
    
    [bool] $ZahlimPasswort = $false

    # Falls kein Wert eingegeben wird, ist die Lï¿½nge 13
    if ( 0 -eq $length)
    {
    $length = 13
    }

    $uyear = Get-Date -Uformat %y
    $umonth = Get-Date -Uformat %m
    $logfile = "c:\logs\Get-RandomPassword.log"

    new-item -itemtype File $logfile -ErrorAction SilentlyContinue
    
    #write-host "Zahl im Passwort = " $ZahlimPasswort
        While($ZahlimPasswort -eq $false)
    {
    
    #$charSet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789{]+-[*=@:)}$^%;(_!&amp;#?>/|.'.ToCharArray()
    $charSet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.ToCharArray()
    $rng = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
    $bytes = New-Object byte[]($length)
 
    $rng.GetBytes($bytes)
 
    $result = New-Object char[]($length)

        for ($i = 0 ; $i -lt $length ; $i++) {
        $result[$i] = $charSet[$bytes[$i]%$charSet.Length]
		}

    if($result -match "[0-9]")
        {
        $ZahlimPasswort = $true
        #write-Host "Zahl im Passwort = "$ZahlimPasswort
        $output = [string]::Join("", $result)
        #$resultstring = $resultstring.replace(" ","")
        Add-Content -Path $logFile -Value "$uyear$umonth : $output : $note"
                           return (-join $output)
        }
    }
    }
