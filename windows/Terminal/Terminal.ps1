function Set-WindowsTerminal {
    [CmdLetBinding()]
    Param(
        [Parameter (Mandatory = $False)]$sourceFolder = $DotfilesFolder,
        [Parameter (Mandatory = $True)]$TerminalBackgroundImage
    )
    
    
    $TerminalSettingsFile = Join-path $DotfilesFolder 'windows\Terminal\settings.json'
    $WindowsTerminalSettingsFilePath = Join-Path -Path $env:LOCALAPPDATA -ChildPath "Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json";
    
    If(Test-Path $TerminalBackgroundImage){
        $TerminalBackgroundImage = (Get-Item -Path $TerminalBackgroundImage).FullName.Replace('\',"\\")
    }
      
    Write-Host "Copying Windows Terminal settings and applying background configuration:" -ForegroundColor "Green";
    Copy-Item $TerminalSettingsFile -Destination $WindowsTerminalSettingsFilePath;
  
    (Get-Content -path $WindowsTerminalSettingsFilePath) -replace "__background_Image__", $TerminalBackgroundImage | Set-Content -Path $WindowsTerminalSettingsFilePath;
  
    Write-Host "Windows Terminal configured." -ForegroundColor "Green";
  }