# Installer script for Windows Machines

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run with administrator priviliges"
    exit $?
}

$ScriptFolder = Split-Path $myInvocation.MyCommand.Definition
$CommonFolder = Join-Path $ScriptFolder "common"

. (Join-Path $CommonFolder 'pwsh\hlpWinget.ps1')

Deploy-WingetPackage -PackageName 'Microsoft.WindowsTerminal'
Deploy-WingetPackage -PackageName 'Microsoft.VisualStudioCode'
Deploy-WingetPackage -PackageName 'Microsoft.AzureCLI'
Deploy-WingetPackage -PackageName 'Microsoft.Bicep'
Deploy-WingetPackage -PackageName 'Microsoft.PowerShell'
Deploy-WingetPackage -PackageName 'Microsoft.PowerToys'
Deploy-WingetPackage -PackageName 'Microsoft.AzureStorageExplorer'
Deploy-WingetPackage -PackageName 'JanDeDobbeleer.OhMyPosh'
Deploy-WingetPackage -PackageName 'Git.Git'
Deploy-WingetPackage -PackageName 'PuTTY.PuTTY'
Deploy-WingetPackage -PackageName 'Notepad++.Notepad++'

# Deploy PowerShell Profile files
$MyDocuments = [Environment]::GetFolderPath("MyDocuments")

$PowerShellFolders = @("PowerShell", "WindowsPowerShell")
ForEach($PowerShellFolder in $PowerShellFolders){
    $TargetFolder = Join-Path ($MyDocuments) $PowerShellFolder
    Write-Host "Copy PowerShell profile to" $TargetFolder  -ForegroundColor Green
    If(-Not (Test-Path $TargetFolder)){
        New-Item -Path $TargetFolder -ItemType Directory -Force | Out-Null
    } 

    $VSCodeFile = Join-Path $TargetFolder "Microsoft.VSCode_profile.ps1"
    Copy-Item (Join-Path $CommonFolder 'pwsh\Microsoft.PowerSHell_Profile.ps1') -Destination $TargetFolder -Force -Confirm:$false
    Copy-Item (Join-Path $CommonFolder 'pwsh\Microsoft.PowerSHell_Profile.ps1') -Destination $VSCodeFile -Force -Confirm:$false
}