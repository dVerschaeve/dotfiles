


Function Search-NerdFont(){
    [CmdLetBinding()]
    Param(
        [Parameter (Mandatory = $True)]$FontName
    )

    Begin{
        $NerdFontSite = "https://www.nerdfonts.com/font-downloads"
        $ReturnURI = $Null
    }

    Process{
        $response = Invoke-WebRequest -UseBasicParsing -Uri $NerdFontSite -ErrorAction SilentlyContinue
        $OTDUri = $response.links | Where-Object {$_.outerHTML -like ("*{0}*" -f $FontName)} | Select-Object -First 1
        If($Null -ne $OTDUri){
            $ReturnURI = $OTDUri.href
        }

    }
    End {
        
        $ReturnURI
    }
}



Function Get-NerdFont(){
    [CmdLetBinding()]
    Param(
        [Parameter (Mandatory = $True)]$FontName,
        [Parameter (Mandatory = $False)]$TempFolder = (Join-Path $ScriptFolder "TMP")
    )

    Begin {
        Write-Host ("Downloading and installing nerdfont '{0}'" -f $FontName)
        $FontFolder = Join-Path $env:USERPROFILE "\AppData\Local\Microsoft\Windows\Fonts"
    }

    Process{
        
        $FontURI = Search-NerdFont -FontName $FontName


        New-Item -ItemType Directory -path $TempFolder -Force | Out-Null
        $FontFile = Join-Path $TempFolder (Split-Path $FontURI -Leaf)
        Invoke-WebRequest -Uri $FontURI -OutFile $FontFile
        Expand-Archive -LiteralPath $FontFile -DestinationPath $TempFolder -Force

        $FontShellFolder = (New-Object -ComObject Shell.Application).Namespace(0x14)

        $FontFiles = Get-ChildItem -Path $TempFolder -Filter *.ttf
        ForEach($File in $FontFiles){
            If(-Not(Test-Path (Join-Path $FontFolder $File.Name))){
                Write-Host ("Install Font '{0}'" -f $File.name)
                $FontShellFolder.CopyHere($File.Fullname,0x10)
            } Else {
                Write-Host("Font '{0}' already installed" -f $File.Name)
            }
        }

        Remove-item -Path $TempFolder -Recurse -Confirm:$False -Force
    }
} 
