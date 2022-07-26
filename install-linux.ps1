
$ScriptFolder = Split-Path $myInvocation.MyCommand.Definition
$CommonFolder = Join-Path $ScriptFolder "common"
$WindowsFolder = Join-Path $ScriptFolder "windows"

. (Join-Path $CommonFolder 'pwsh\variables.ps1') #Import Variables from file

Write-Host $DotfilesFolder 

# Deploy PowerShell Profile files


$MyDocuments = Join-Path ${HOME} ".config"

$PowerShellFolders = @("powershell")
ForEach($PowerShellFolder in $PowerShellFolders){
    $TargetFolder = Join-Path ($MyDocuments) $PowerShellFolder
    Write-Host "Copy PowerShell profile to" $TargetFolder  -ForegroundColor Green
    If(-Not (Test-Path $TargetFolder)){
        New-Item -Path $TargetFolder -ItemType Directory -Force | Out-Null
    } 

    $VSCodeFile = Join-Path $TargetFolder "Microsoft.VSCode_profile.ps1"
    Copy-Item (Join-Path $CommonFolder 'pwsh\Microsoft.PowerShell_profile.ps1') -Destination $TargetFolder -Force -Confirm:$false
    Copy-Item (Join-Path $CommonFolder 'pwsh\Microsoft.PowerShell_profile.ps1') -Destination $VSCodeFile -Force -Confirm:$false
}
