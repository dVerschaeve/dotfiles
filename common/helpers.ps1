Function Get-WingetPackage(){
    [CmdLetBinding()]
    Param(
        [Parameter (Mandatory = $True)][String]$PackageName
    )

    Begin {
        $Result = $null
        $WingetPackageInfo = winget list --id $PackageName -e | Out-String
    }

    Process {
        If(-not ($WingetPackageInfo -Like ("*No installed package found matching input criteria.*"))){
            $lines = $WingetPackageInfo.Split([Environment]::NewLine)

            $fl = 0
            while (-not $lines[$fl].StartsWith("Name"))
            {
                $fl++
            }

            $idStart = $lines[$fl].IndexOf("Id")
            $versionStart = $lines[$fl].IndexOf("Version")
            $availableStart = $lines[$fl].IndexOf("Available")
            $sourceStart = $lines[$fl].IndexOf("Source")
            
            For ($i = $fl + 1; $i -le $lines.Length; $i++) 
            {
                $line = $lines[$i]
                If ($line.Length -gt ($availableStart + 1) -and -not $line.StartsWith('-'))
                {
                    $name = $line.Substring(0, $idStart).TrimEnd()
                    $id = $PackageName
                                    
                    If($availableStart -gt 0){
                        $version = $line.Substring($versionStart, $availableStart - $versionStart).TrimEnd()
                        $available = $line.Substring($availableStart, $sourceStart - $availableStart).TrimEnd()
                        $Upgradable = $True
                    } Else {
                        $available = $null
                        $version = $line.Substring($versionStart, $sourceStart - $versionStart).TrimEnd()
                        $Upgradable = $False
                    }
                    

                    $Software = [PSCustomObject]@{
                        Name = $name
                        Id = $id
                        Version = $version
                        AvailableVersion = $available
                        Upgradable = $Upgradable
                    }
            
                    $Result = $Software
                } 
            }
        }
    }

    End {
        $Result
    }
}

Function Deploy-WingetPackage(){
    [CmdLetBinding()]
    Param(
        [Parameter (Mandatory=$True)][String]$PackageName
    )

    $WingetPackage = Get-WingetPackage -PackageName $PackageName
    If($Null -eq $WingetPackage){
        Write-Host "Deploying $PackageName" -ForegroundColor Yellow
        winget install $PackageName --exact --silent --accept-package-agreements
    } Else {
        Write-Host "Package $PackageName already installed" -ForegroundColor Green
        If($WingetPackage.Upgradable -eq $True){
            Write-Host "Installing available update" $WingetPackage.AvailableVersion -ForegroundColor Yellow
            winget upgrade --id $PackageName --exact --silent --accept-package-agreements
        }
    }
}